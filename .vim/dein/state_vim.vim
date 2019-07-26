if g:dein#_cache_version !=# 150 || g:dein#_init_runtimepath !=# '/Users/wayama/.vim,/usr/local/share/vim/vimfiles,/usr/local/share/vim/vim81,/usr/local/share/vim/vimfiles/after,/Users/wayama/.vim/after,/Users/wayama/.vim/dein/repos/github.com/Shougo/dein.vim' | throw 'Cache loading error' | endif
let [plugins, ftplugin] = dein#load_cache_raw(['/Users/wayama/.vimrc'])
if empty(plugins) | throw 'Cache loading error' | endif
let g:dein#_plugins = plugins
let g:dein#_ftplugin = ftplugin
let g:dein#_base_path = '/Users/wayama/.vim/dein'
let g:dein#_runtime_path = '/Users/wayama/.vim/dein/.cache/.vimrc/.dein'
let g:dein#_cache_path = '/Users/wayama/.vim/dein/.cache/.vimrc'
let &runtimepath = '/Users/wayama/.vim,/usr/local/share/vim/vimfiles,/Users/wayama/.vim/dein/repos/github.com/Shougo/dein.vim,/Users/wayama/.vim/dein/.cache/.vimrc/.dein,/usr/local/share/vim/vim81,/Users/wayama/.vim/dein/.cache/.vimrc/.dein/after,/usr/local/share/vim/vimfiles/after,/Users/wayama/.vim/after'
filetype off
