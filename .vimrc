syntax on

set number
set expandtab
set mouse=a
set tabstop=4
set shiftwidth=4
set softtabstop=4
set autoindent
set smartindent
set smarttab
set shiftwidth=4
set cursorline
set hlsearch
set scrolloff=5
set encoding=utf-8

set wrap

set updatetime=0 
set nowrapscan "検索がファイル末尾まで進んだらそこで先頭に戻らず止まる
"set wrapscan "行末まで検索したら行頭に戻る
set showmatch
set matchtime=1
set backspace=start,eol,indent
set nostartofline " カーソル：括弧を閉じたとき対応する括弧に一時的に移動

set ttyfast
set t_Co=256

" Unix系 (Linux, macOS)
if has('unix')
endif

" macOS
if has('macunix')
    set clipboard+=unnamed
endif

" Windows
if has('win32') || has('win64')
endif

" WSL
if has('wsl')

    " 240515: wslでyankをクリップボードに入れる。win32yank.exeを使う場合。
    if executable('win32yank.exe')
      " ヤンク後にクリップボードにコピー
      augroup clipboard
        autocmd!
        " autocmd TextYankPost * call system('win32yank.exe -i', @")
        autocmd TextYankPost * if v:event.operator ==# 'y' | call system('win32yank.exe -i', @") | endif
      augroup END
    
    
      " クリップボードからペーストする関数
      function! Paste(p)
        let sysclip = system('win32yank.exe -o')
        if sysclip != @"
          let @" = sysclip
        endif
        return a:p
      endfunction
    
    
      " ペーストマッピング
      noremap <expr> p Paste('p')
      noremap <expr> P Paste('P')
    
    
    endif
    
    set clipboard=unnamed
    let g:clipboard = {
            \   'name': 'myClipboard',
            \   'copy': {
            \      '+': 'win32yank.exe -i',
            \      '*': 'win32yank.exe -i',
            \    },
            \   'paste': {
            \      '+': 'win32yank.exe -o',
            \      '*': 'win32yank.exe -o',
            \   },
            \   'cache_enabled': 1,
            \ }
endif

colorscheme lucius
LuciusDarkHighContrast

set fileencoding=utf-8
set fileencodings=ucs-boms,utf-8,euc-jp,cp932
set fileformats=unix,dos,mac
set ambiwidth=double

set incsearch
set ignorecase
set smartcase
set hlsearch
set whichwrap=b,s,h,l,<,>,[,],~

set wildmenu
set history=5000

let mapleader = "\<Space>"
let $BASH_ENV = "~/.bash_aliases"
let $ZSH_ENV = "~/.zsh_aliases"

set swapfile
set dir=~/swap

" 折りたたみ
set foldmethod=indent
set foldlevel=4
" set foldcolumn=3

" 折りたたみの状態を保存
" buffer file が必要になるので一度コメントアウト
" au BufWinLeave * mkview
" au BufWinEnter * silent loadview

""""""""""""""""""""""""""""""""""""""""""""""
" https://maku77.github.io/vim/advanced/folding.html
" 折りたたみと展開（カーソル位置の要素に対して）
"   zc  -- 折りたたみ (Close one fold under the cursor)
"   zo  -- 展開（一段階）(Open one fold under the cursor)
"   zO  -- 展開（すべて）(Open all folds under the cursor recursively)
" 
" 折りたたみと展開（ファイル全体の要素に対して）
"   zm -- 折りたたみ（一段階） (Fold more)
"   zM -- 折りたたみ（すべて） (Close all folds)
"   zr -- 展開（一段階） (Reduce folding)
"   zR -- 展開（すべて） (Open all folds)

""""""""""""""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""
" install vim plugin

""""""""""""""""""""""""""""""""""""""""""""""
" gitコマンドをvimから実行するプラグイン(vim-fugitive)をインストールするために必要
" https://github.com/tpope/vim-fugitive
" https://github.com/tpope/vim-pathogen
" execute pathogen#infect()

""""""""""""""""""""""""""""""""""""""""""""""
" start vim-plug
"   Markdownをリアルタイムにブラウザで表示するプラグイン
"   表示位置なども自動的に追従
"
"   https://github.com/iamcco/markdown-preview.nvim
"
"     install : :PlugInstall
"     Preview : :MarkdownPreview
"
"     nvimでなくvim XXXX.mdでもブラウザで表示できる
"
" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

call plug#begin('~/.config/nvim/plugged')

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
Plug 'junegunn/vim-easy-align'
Plug 'mechatroner/rainbow_csv'

" " Any valid git URL is allowed
" Plug 'https://github.com/junegunn/vim-github-dashboard.git'
" 
" " Multiple Plug commands can be written in a single line using | separators
" Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
" 
" " On-demand loading
" Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
" Plug 'tpope/vim-fireplace', { 'for': 'clojure' }
" 
" " Using a non-master branch
" Plug 'rdnetto/YCM-Generator', { 'branch': 'stable' }
" 
" " Using a tagged release; wildcard allowed (requires git 1.9.2 or above)
" Plug 'fatih/vim-go', { 'tag': '*' }
" 
" " Plugin options
" Plug 'nsf/gocode', { 'tag': 'v.20150303', 'rtp': 'vim' }
" 
" " Plugin outside ~/.vim/plugged with post-update hook
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
" 
" Initialize plugin system
"

"190913: syntax-highlight for tsx
Plug 'leafgarland/typescript-vim'
Plug 'peitalin/vim-jsx-typescript'

Plug 'preservim/nerdtree'

Plug 'ctrlpvim/ctrlp.vim'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'nvim-tree/nvim-web-devicons'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.6' }

Plug 'github/copilot.vim'

Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

call plug#end()
""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""
" markdown-preview config
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = ''
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {'theme': 'simple'}
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'

nmap <Leader>mp <Plug>MarkdownPreview
nmap <Leader>mps <Plug>MarkdownPreviewStop
nmap <Leader>mpst <Plug>MarkdownPreviewToggle

" end markdown-preview
""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
""""""""""""""""""""""""""""""""""""""""""""""

nmap <C-t> :NERDTreeToggle<CR>

""""""""""""""""""""""""""""""""""""""""""""""
" pythonファイルの場合、tabを4にするように明示的に記載
au Filetype python setl et ts=4 sw=4

"""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax enable

nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

noremap j gj
noremap k gk
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $
noremap m  % 
nnoremap <CR> A<CR><ESC>
nnoremap == gg=G''

nnoremap <Leader>p "0p
nnoremap <Leader>P "0P
nnoremap <Leader>cp "*P
nnoremap <Leader>cP "*P

nnoremap <C-S-p> diw"0P

nnoremap <Space>v  :vs<CR>:<C-u>VimShell<CR>
nnoremap <Space>tl  :vs<CR>:TweetVimHomeTimeline<CR>
nnoremap <Space>tm  :vs<CR>:TweetVimMentions<CR>
nnoremap <Space>ts  :TweetVimSay<CR>

inoremap <C-f> <C-x><C-o>

""C-sでノーマルモードへ移動し保存inoremap <C-s> <Esc>:wa<CR>
nnoremap <C-s> :wa<CR>

""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""
inoremap <C-v> <ESC>"*pa
"ダブルクオテーションを二つ付加し、カーソルを戻す
inoremap " ""<ESC>ha

" 括弧の自動補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>


""""""""""""""""""""""""""""""""""
""160526_挿入モードのまま一文字飛ばして移動とノーマルモードへ移行を簡単にキーマッピング
inoremap <C-j> <ESC>gja
inoremap <C-k> <ESC>gka
inoremap <C-h> <ESC>ha
inoremap <C-l> <ESC>la
""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""
""160609_http://qiita.com/inodev/items/4f4d5412e65c2564b273
""全角スペースの可視化
highlight ZenkakuSpace cterm=underline ctermfg=lightblue guibg=#666666
au BufNewFile,BufRead * match ZenkakuSpace /　/

""jjでインサートモードからコマンドモードに戻る
inoremap <silent> jj <ESC>

""検索語が画面の真ん中
nmap n nzz 
nmap N Nzz 
nmap * *zz 
nmap # #zz 
nmap g* g*zz 
nmap g# g#zz

""貼り付けた後、カーソルを末尾へ移動
nnoremap <silent> p p`]
nnoremap <silent> P P`]

nnoremap <S-y> y$

""load vimrc
noremap <F1> <ESC>:source ~/.vimrc<CR>
inoremap <F1> <ESC>:source ~/.vimrc<CR>

""php
noremap <F2> <ESC>:wa<CR>:!php %<CR>
inoremap <F2> <ESC>:wa<CR>:!php %<CR>

""java buiild
noremap <F3> <ESC>:wa<CR>:!javac %<CR>
inoremap <F3> <ESC>:wa<CR>:!javac %<CR>

""java execute
noremap <F4> <ESC>:wa<CR>:!java %:r<CR>
inoremap <F4> <ESC>:wa<CR>:!java %:r<CR>

""python execute
noremap <F5> <ESC>:wa<CR>:!python %<CR>
inoremap <F5> <ESC>:wa<CR>:!python %<CR>

""go execute
noremap <F6> <ESC>:wa<CR>:!go run %<CR>
inoremap <F6> <ESC>:wa<CR>:!go run %<CR>

""go build
noremap <F7> <ESC>:wa<CR>:!go build -o %:r %<CR>
inoremap <F7> <ESC>:wa<CR>:!go build -o %:r %<CR>

""ruby execute
noremap <F8> <ESC>:wa<CR>:!ruby %<CR>
inoremap <F8> <ESC>:wa<CR>:!ruby %<CR>

""bash execute
noremap <F9> <ESC>:wa<CR>:!bash %<CR>
inoremap <F9> <ESC>:wa<CR>:!bash %<CR>

""node execute
noremap <F10> <ESC>:wa<CR>:!node %<CR>
inoremap <F10> <ESC>:wa<CR>:!node %<CR>

""ファイル名を取得して追記
noremap gf <ESC>:r! echo %<CR>
inoremap gf <ESC>:r! echo %<CR>

"" auto closer
nnoremap <Leader>" ciw""<Esc>P
nnoremap <Leader>' ciw''<Esc>P
nnoremap <Leader>` ciw``<Esc>P
nnoremap <Leader>( ciw()<Esc>P
nnoremap <Leader>{ ciw{}<Esc>P
nnoremap <Leader>[ ciw[]<Esc>P

"" quote
nnoremap <Leader>qb i```bash<CR><CR>```<ESC><UP>i<Space><Space><ESC>
nnoremap <Leader>qp i```python<CR><CR>```<ESC><UP>i<Space><Space><ESC>
nnoremap <Leader>qr i```ruby<CR><CR>```<ESC><UP>i<Space><Space><ESC>
nnoremap <Leader>qj i```javascript<CR><CR>```<ESC><UP>i<Space><Space><ESC>

""katex vim
nnoremap <Leader>kfrac i\frac{}{}<Left><Left><Left><Esc>
nnoremap <Leader>ksum i\sum_{k=}^{}<Left><Left><Left><Esc>
nnoremap <Leader>kint i\int_{-\infty}^{\infty}<Left><Left><Left><Esc>
nnoremap <Leader>kbd i\frac{N!}{r!<Space>\(N-r\)!}<Space>\times<Space>\left(\frac{\theta}{n}\right)^r<Space>\times<Space>\left(\frac{n-\theta}{n}\right)^{N-r}<Esc>
nnoremap <Leader>kpd i\frac{\lambda^ke^{-\lambda}}{k!}<Esc>

nnoremap <Leader>knbd i$$ P\left(r \right) = \frac{\left(1 + \frac{M}{K} \right)^{-K} \cdot \Gamma\left(K + r \right)}{\Gamma\left(r + 1 \right)\cdot \Gamma\left(K \right)} \cdot \left(\frac{M}{M+K} \right)^r \cdots \left(1 \right)$$<Esc>

nnoremap <Leader>kdot i\,\,\,\,\cdot\cdot\cdot\cdot\,\,\,\,\left(\right)<Esc>b<Left>i<Esc>

nnoremap <Leader>k$ i$\displaystyle<Space>$<Left>
nnoremap <Leader>k$$ i$$<Space><Space>$$<Left><Left><Left>
nnoremap <Leader>k( i\left(<Space>\right)<Esc>F<Space>
nnoremap <Leader>k{ i\left{<Space>\right}<Esc>F<Space>
nnoremap <Leader>k[ i\left[<Space>\right]<Esc>F<Space>

nnoremap <Leader>kred i<font color="MediumVioletRed"> </font><Esc>F<Space>

nnoremap <Leader>ka i\alpha<Esc>
nnoremap <Leader>kb i\bata<Esc>
nnoremap <Leader>kc i\gamma<Esc>
nnoremap <Leader>kd i\delta<Esc>
nnoremap <Leader>kl i\mu<Esc>
nnoremap <Leader>kl i\lambda<Esc>

nnoremap <Leader>kC i\Gamma<Esc>
nnoremap <Leader>kD i\Delta<Esc>

nnoremap <Leader>kbays i$$ P \left( \theta \| X \right) =\frac{P\left(X \| \theta \right)P\left(\theta \right)}{P\left( X\right)} $$<Esc>

nnoremap <Leader>kpt i<Space>$\displaystyle<Space>P\left( \theta \right)$<Space><Left>

nnoremap <Leader>kpx i<Space>$\displaystyle<Space>P\left( X \right)$<Space><Left>

nnoremap <Leader>kptx i<Space>$\displaystyle<Space>P\left( \theta \| X \right)$<Space><Left>

nnoremap <Leader>kpxt i<Space>$\displaystyle<Space>P\left( X \| \theta \right)$<Space><Left>

""日本語のジャンプ
nnoremap <Leader>f. f。<Esc>
nnoremap <Leader>f, f、<Esc>
nnoremap <Leader>F. F。<Esc>
nnoremap <Leader>F, F、<Esc>

nnoremap <Leader>f1 f１<Esc>
nnoremap <Leader>f2 f２<Esc>
nnoremap <Leader>f3 f３<Esc>
nnoremap <Leader>f4 f４<Esc>
nnoremap <Leader>f5 f５<Esc>
nnoremap <Leader>f6 f６<Esc>
nnoremap <Leader>f7 f７<Esc>
nnoremap <Leader>f8 f８<Esc>
nnoremap <Leader>f9 f９<Esc>
nnoremap <Leader>f0 f０<Esc>

nnoremap <Leader>F1 F１<Esc>
nnoremap <Leader>F2 F２<Esc>
nnoremap <Leader>F3 F３<Esc>
nnoremap <Leader>F4 F４<Esc>
nnoremap <Leader>F5 F５<Esc>
nnoremap <Leader>F6 F６<Esc>
nnoremap <Leader>F7 F７<Esc>
nnoremap <Leader>F8 F８<Esc>
nnoremap <Leader>F9 F９<Esc>
nnoremap <Leader>F0 F０<Esc>

nnoremap <Leader>dt, dt、<Esc>
nnoremap <Leader>dt. dt。<Esc>
nnoremap <Leader>df, df、<Esc>
nnoremap <Leader>df. df。<Esc>

nnoremap <Leader>fto fと<Esc>
nnoremap <Leader>fha fは<Esc>
nnoremap <Leader>fde fで<Esc>
nnoremap <Leader>fni fに<Esc>
nnoremap <Leader>fno fの<Esc>

nnoremap <Leader>Fto Fと<Esc>
nnoremap <Leader>Fha Fは<Esc>
nnoremap <Leader>Fde Fで<Esc>
nnoremap <Leader>Fni Fに<Esc>
nnoremap <Leader>Fno Fの<Esc>

nnoremap <Leader>, i、<Esc>
nnoremap <Leader>. i。<Esc>

" vim script test 
" function! Testtemp()
" 	execute ":'<,'>s/\\([a-z].*\\)/\"\\u\\1_\\1\"/g"
" endfunction
" :command! Testtemp call Testtemp()
" nmap <C-y> :Testtemp<CR>

" remove first white spaces 
function! Rfw()
    execute ":%s/^[\\t 　]*\\n/\xD/g"
endfunction
:command! Rfw call Rfw()
nmap <C-y> :Rfw<CR>


if &term =~ "xterm"
  let &t_ti .= "\e[?2004h"
  let &t_te .= "\e[?2004l"
  let &pastetoggle = "\e[201~"

  function XTermPasteBegin(ret)
      set paste
      return a:ret
  endfunction

  noremap <special> <expr> <Esc>[200~ XTermPasteBegin("0i")
  inoremap <special> <expr> <Esc>[200~ XTermPasteBegin("")
  cnoremap <special> <Esc>[200~ <nop>
  cnoremap <special> <Esc>[201~ <nop>
endif

runtime! private/*.vim

" binary 
augroup BinaryXXD
  autocmd!
  autocmd BufReadPost * if &binary | silent %!xxd -g 1
  autocmd BufReadPost * set ft=xxd | endif
  autocmd BufWritePre * if &binary | %!xxd -r
  autocmd BufWritePre * endif
  autocmd BufWritePost * if &binary | silent %!xxd -g 1
  autocmd BufWritePost * set nomod | endif
augroup END

"""""""""""""""""""""""""""""
" aligment xml by vim
function! Axml()
  execute ":%s/></>\r</g | filetype indent on | setf xml | normal gg=G"
endfunction

:command! Axml call Axml()

"""""""""""""""""""""""""""""
" convert \n to space
" for deepL
" vim で正規表現かつ後方参照する場合
" （）によるグループ化と\\１による後方参照と二つのバックスラッシュ
function! Cnts()
  execute ":%s/\\(\\w\\)\\n\\(\\w\\)/\\1 \\2/g"
endfunction

:command! Cnts call Cnts()

" # macだとsedでの正規表現置換と後方参照が面倒すぎる
" # ここにメモを取っておく
" cat a.txt | sed -e :loop -e 'N; $!b loop' -e 's/\([a-zA-Z0-9]\)\n\([a-zA-Z0-9]\)/\1 \2/g' > a1.txt

" 末尾にバックスラッシュを二つ追加。HUGOのMathJax対策。
function! AddB()
  execute ":'<,'>s/$/\\\\\\\\/g"
endfunction

:command! AddB call AddB()

" diff
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

" for vimdiff setting
let g:netrw_rsync_cmd = 'rsync -a --no-o --no-g --rsync-path="sudo rsync" -e "ssh -oPermitLocalCommand=no"'

