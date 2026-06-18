" WSL2 固有の設定

" クリップボード連携: win32yank.exe 経由
if executable('win32yank.exe')
  set clipboard=unnamed
  let g:clipboard = {
        \   'name': 'wsl_clipboard',
        \   'copy': {
        \     '+': 'win32yank.exe -i',
        \     '*': 'win32yank.exe -i',
        \   },
        \   'paste': {
        \     '+': 'win32yank.exe -o',
        \     '*': 'win32yank.exe -o',
        \   },
        \   'cache_enabled': 1,
        \ }
endif
