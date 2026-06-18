#!/bin/bash
set -euo pipefail
shopt -s nullglob

# ---------------------------------------------------------------------------
# Dotfiles installer
# Usage: ./install.sh [-n]
#   -n  Dry run (show what would be done without making changes)
# ---------------------------------------------------------------------------

DRY_RUN=false
while getopts "n" opt; do
  case "$opt" in
    n) DRY_RUN=true ;;
    *) echo "Usage: $0 [-n]" >&2; exit 1 ;;
  esac
done

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

run() {
  if "$DRY_RUN"; then
    echo "[dry-run] $*"
  else
    "$@"
  fi
}

symlink() {
  local src="$1"
  local dst="$2"
  echo "symlink: $src -> $dst"

  if "$DRY_RUN"; then
    return 0
  fi

  if [[ -e "$dst" || -L "$dst" ]]; then
    if [[ -d "$dst" && ! -L "$dst" ]]; then
      mv "$dst" "${dst}.bak.$(date +%Y%m%d%H%M%S)"
    else
      rm -f "$dst"
    fi
  fi

  ln -s "$src" "$dst"
}

echo "==> Starting dotfiles install (dry-run: $DRY_RUN)"

# ---------------------------------------------------------------------------
# OS パッケージのインストール
# ---------------------------------------------------------------------------
echo ""
echo "==> Installing OS packages"

_pkg_list_install() {
  local pkg_file="$1"
  # コメント行と空行を除いてパッケージ名のみ抽出
  grep -v '^\s*#' "$pkg_file" | grep -v '^\s*$'
}

if [[ "$(uname -s)" == "Darwin" ]] && command -v brew >/dev/null 2>&1; then
  pkg_file="$SCRIPT_DIR/packages/brew.txt"
  echo "  detected: macOS (Homebrew)"
  while IFS= read -r pkg; do
    if brew list "$pkg" >/dev/null 2>&1; then
      echo "  (already installed: $pkg)"
    else
      echo "  installing: $pkg"
      run brew install "$pkg"
    fi
  done < <(_pkg_list_install "$pkg_file")

elif command -v pacman >/dev/null 2>&1; then
  pkg_file="$SCRIPT_DIR/packages/pacman.txt"
  echo "  detected: Arch Linux (pacman)"
  pkgs=()
  while IFS= read -r pkg; do
    if pacman -Q "$pkg" >/dev/null 2>&1; then
      echo "  (already installed: $pkg)"
    else
      pkgs+=("$pkg")
    fi
  done < <(_pkg_list_install "$pkg_file")
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    echo "  installing: ${pkgs[*]}"
    run sudo pacman -S --needed --noconfirm "${pkgs[@]}"
  fi

elif command -v apt-get >/dev/null 2>&1; then
  pkg_file="$SCRIPT_DIR/packages/apt.txt"
  echo "  detected: Debian/Ubuntu (apt)"
  run sudo apt-get update -qq
  pkgs=()
  while IFS= read -r pkg; do
    if dpkg -s "$pkg" >/dev/null 2>&1; then
      echo "  (already installed: $pkg)"
    else
      pkgs+=("$pkg")
    fi
  done < <(_pkg_list_install "$pkg_file")
  if [[ ${#pkgs[@]} -gt 0 ]]; then
    echo "  installing: ${pkgs[*]}"
    run sudo apt-get install -y "${pkgs[@]}"
  fi

else
  echo "  [skip] no supported package manager found (pacman/apt/brew)"
fi

# ---------------------------------------------------------------------------
# Dotfiles: symlink all hidden files/dirs (except .git, .DS_Store, .github, .codex, .config)
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking dotfiles to $HOME"
cd "$SCRIPT_DIR"
for f in .??*; do
  [[ "$f" == ".git" ]]     && continue
  [[ "$f" == ".DS_Store" ]] && continue
  [[ "$f" == ".github" ]]   && continue
  [[ "$f" == ".codex" ]]    && continue
  [[ "$f" == ".config" ]]   && continue  # managed per-file below
  symlink "$SCRIPT_DIR/$f" "$HOME/$f"
done

# ---------------------------------------------------------------------------
# bin: personal scripts
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking bin scripts"
run mkdir -p "$HOME/bin"
for script in "$SCRIPT_DIR/bin/"*; do
  symlink "$script" "$HOME/bin/$(basename "$script")"
done

# ---------------------------------------------------------------------------
# Neovim: link init.vim to .vimrc
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking nvim config"
run mkdir -p "$HOME/.config/nvim"
symlink "$SCRIPT_DIR/.vimrc" "$HOME/.config/nvim/init.vim"

# ---------------------------------------------------------------------------
# mise: global tool config
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking mise global config"
run mkdir -p "$HOME/.config/mise"
symlink "$SCRIPT_DIR/.config/mise/config.toml" "$HOME/.config/mise/config.toml"

# ---------------------------------------------------------------------------
# sheldon: zsh plugin manager config
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking sheldon config"
run mkdir -p "$HOME/.config/sheldon"
symlink "$SCRIPT_DIR/.config/sheldon/plugins.toml" "$HOME/.config/sheldon/plugins.toml"

# ---------------------------------------------------------------------------
# atuin: shell history config
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking atuin config"
run mkdir -p "$HOME/.config/atuin"
symlink "$SCRIPT_DIR/.config/atuin/config.toml" "$HOME/.config/atuin/config.toml"

# ---------------------------------------------------------------------------
# Git config
# ---------------------------------------------------------------------------
echo ""
echo "==> Copying .gitconfig.local -> ~/.gitconfig"
run cp "$SCRIPT_DIR/.gitconfig.local" "$HOME/.gitconfig"

# ---------------------------------------------------------------------------
# VS Code settings
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking VS Code settings"
VSCODE_DIR=""
if [[ -d "$HOME/Library/Application Support/Code/User" ]]; then
  VSCODE_DIR="$HOME/Library/Application Support/Code/User"
elif [[ -d "$HOME/.config/Code/User" ]]; then
  VSCODE_DIR="$HOME/.config/Code/User"
fi
if [[ -n "$VSCODE_DIR" ]]; then
  run mkdir -p "$VSCODE_DIR/snippets"
  run mkdir -p "$VSCODE_DIR/prompts"
  symlink "$SCRIPT_DIR/vscode/settings.json"    "$VSCODE_DIR/settings.json"
  symlink "$SCRIPT_DIR/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"
  shopt -s nullglob
  for snippet in "$SCRIPT_DIR/vscode/snippet/"*.json; do
    symlink "$snippet" "$VSCODE_DIR/snippets/$(basename "$snippet")"
  done
  for prompt in "$SCRIPT_DIR/.github/prompts/"*.prompt.md; do
    symlink "$prompt" "$VSCODE_DIR/prompts/$(basename "$prompt")"
  done
  shopt -u nullglob
else
  echo "  (VS Code user dir not found, skipping)"
fi

# ---------------------------------------------------------------------------
# IPython: enable Vim edit mode
# ---------------------------------------------------------------------------
echo ""
echo "==> Configuring IPython Vim mode"
IPYTHON_CONF="$HOME/.ipython/profile_default/ipython_config.py"
if [[ ! -f "$IPYTHON_CONF" ]]; then
  run mkdir -p "$(dirname "$IPYTHON_CONF")"
  if ! "$DRY_RUN"; then
    echo 'c.TerminalInteractiveShell.editing_mode = "vi"' > "$IPYTHON_CONF"
  fi
else
  echo "  (already exists, skipping)"
fi

# ---------------------------------------------------------------------------
# Vim swap directory
# ---------------------------------------------------------------------------
echo ""
echo "==> Creating ~/swap"
run mkdir -p "$HOME/swap"

# ---------------------------------------------------------------------------
# GitHub config (.github directory)
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking .github directory"
symlink "$SCRIPT_DIR/.github" "$HOME/.github"

# ---------------------------------------------------------------------------
# Copilot CLI skills
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking Copilot CLI skills"
run mkdir -p "$HOME/.copilot/skills"
for skill_dir in "$SCRIPT_DIR/.github/skills/"*/; do
  skill_name="$(basename "$skill_dir")"
  symlink "$skill_dir" "$HOME/.copilot/skills/$skill_name"
done

# ---------------------------------------------------------------------------
# git diff-highlight
# ---------------------------------------------------------------------------
echo ""
echo "==> Linking diff-highlight"
DIFF_HIGHLIGHT_SRC=/usr/local/share/git-core/contrib/diff-highlight/diff-highlight
DIFF_HIGHLIGHT_DST=/usr/local/bin/diff-highlight
if [[ -x "$DIFF_HIGHLIGHT_SRC" && ! -e "$DIFF_HIGHLIGHT_DST" ]]; then
  symlink "$DIFF_HIGHLIGHT_SRC" "$DIFF_HIGHLIGHT_DST"
else
  echo "  (skipping: missing source or destination already exists)"
fi

# ---------------------------------------------------------------------------
# mise: install all tools
# ---------------------------------------------------------------------------
echo ""
echo "==> Running mise install"
if command -v mise >/dev/null 2>&1; then
  run mise install || echo "  [warn] mise install failed. You can retry with: mise install"
else
  echo "  [skip] mise not found. Install from https://mise.jdx.dev/getting-started.html"
fi

# ---------------------------------------------------------------------------
# GitHub CLI extensions
# ---------------------------------------------------------------------------
echo ""
echo "==> Installing GitHub CLI extensions"
if command -v gh >/dev/null 2>&1; then
  gh_extensions=(
    "dlvhdr/gh-dash"             # PR/Issue dashboard
    "yusukebe/gh-markdown-preview" # Markdown preview
  )
  for ext in "${gh_extensions[@]}"; do
    ext_name="${ext##*/}"
    if gh extension list 2>/dev/null | grep -q "$ext_name"; then
      echo "  (already installed: $ext_name)"
    else
      echo "  installing: $ext"
      run gh extension install "$ext"
    fi
  done
else
  echo "  [skip] gh not found. Install from https://cli.github.com/"
fi

echo ""
echo "==> Done."
