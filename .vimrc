syntax on

set number
set expandtab
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set smarttab
set shiftwidth=2
set cursorline
set hlsearch
set scrolloff=5
set encoding=utf-8

set updatetime=0 
set nowrapscan "検索がファイル末尾まで進んだらそこで先頭に戻らず止まる
"set wrapscan "行末まで検索したら行頭に戻る
set showmatch
set matchtime=1
set backspace=start,eol,indent
set nostartofline " カーソル：括弧を閉じたとき対応する括弧に一時的に移動
set ttyfast
set t_Co=256

set clipboard=unnamed,autoselect

set fileencoding=utf-8 " 保存時の文字コード
set fileencodings=ucs-boms,utf-8,euc-jp,cp932 " 読み込み時の文字コードの自動判別. 左側が優先される
set fileformats=unix,dos,mac " 改行コードの自動判別. 左側が優先される
set ambiwidth=double " □や○文字が崩れる問題を解決

set incsearch " インクリメンタルサーチ. １文字入力毎に検索を行う
set ignorecase " 検索パターンに大文字小文字を区別しない
set smartcase " 検索パターンに大文字を含んでいたら大文字小文字を区別する
set hlsearch " 検索結果をハイライト
set whichwrap=b,s,h,l,<,>,[,],~ " カーソルの左右移動で行末から次の行の行頭への移動が可能になる

set wildmenu " コマンドモードの補完
set history=5000 " 保存するコマンド履歴の数

let mapleader = "\<Space>"
let $BASH_ENV = "~/.bash_aliases" "aliaaseをvim :!xxxで実行できるようにする

set swapfile
set dir=~/swap


""""""""""""""""""""""""""""""""""""""""""""""
" gitコマンドをvimから実行するプラグイン(vim-fugitive)をインストールするために必要
" https://github.com/tpope/vim-fugitive
" https://github.com/tpope/vim-pathogen
execute pathogen#infect()


""""""""""""""""""""""""""""""""""""""""""""""
" treeを表示するプラグインのインストールa
" https://github.com/scrooloose/nerdtree
" git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
"

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
"
call plug#begin('~/.vim/plugged')

" Make sure you use single quotes

Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & yarn install'  }
" " Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" Plug 'junegunn/vim-easy-align'
" 
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
" " Unmanaged plugin (manually installed and updated)
" Plug '~/my-prototype-plugin'
" 
" Initialize plugin system
call plug#end()

" end vim-plug
""""""""""""""""""""""""""""""""""""""""""""""


""""""""""""""""""""""""""""""""""""""""""""""
" markdown-preview config
"
" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 0

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
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

" use a custom markdown style must be absolute path
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
let g:mkdp_highlight_css = ''

" use a custom port to start server or random for empty
let g:mkdp_port = ''

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

nmap <Leader>mp <Plug>MarkdownPreview
nmap <Leader>mps <Plug>MarkdownPreviewStop
nmap <Leader>mpst <Plug>MarkdownPreviewToggle

" end markdown-preview
""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""
" pythonファイルの場合、tabを2にするように明示的に記載
" plug-in の条件変数設定後のここに記載しないと有効にならない
" autocmd Filetype python setlocal expandtab tabstop=2 shiftwidth=2
au Filetype python setl et ts=2 sw=2


""""""""""""""""""""""""""""""""""""""""""""""
filetype plugin indent on
syntax enable

nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

colorscheme lucius
LuciusDarkHighContrast

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

""言葉の意味：
""ノーマルモード＋ビジュアルモード=noremap 
""コマンドラインモード＋インサートモード=noremap! 
""ノーマルモード=nnoremap 
""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""
""160517_括弧の補完
"" http://qiita.com/shingargle/items/dd1b5510a0685837504a
"" inoremap { {}<Left><CR><ESC><S-o>
"" inoremap ( ()<ESC>i
"" inoremap [ []<ESC>i
inoremap <C-v> <ESC>"*pa
""ダブルクオテーションを二つ付加し、カーソルを戻す
""inoremap " ""<ESC>ha

""180427_レジスタ０の内容をコピペする
""https://qiita.com/ykyk1218/items/8f5471c5e90cc83fd407
""noremap pp "0p
""noremap PP "0P

" 括弧の自動補完
inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap [<Enter> []<Left><CR><ESC><S-o>
inoremap (<Enter> ()<Left><CR><ESC><S-o>

""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""
""160526_挿入モードのまま一文字飛ばして移動とノーマルモードへ移行を簡単にキーマッピング
inoremap <C-j> <ESC>gja
inoremap <C-k> <ESC>gka
inoremap <C-h> <ESC>ha
inoremap <C-l> <ESC>la
""
""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""
"160524_ノーマルモードでタブを押したとき、そのままタブの動作をしてほしい。。。
"noremap <TAB> i<TAB><ESC>
""""""""""""""""""""""""""""""""""
"160525_選択モードでコピーしたものを置き換えて貼り付けるスクリプト
"http://qiita.com/hikaruna/items/83c1220eede810bee492

" vモードの置換連続ペースト用
function! Put_text_without_override_register()
	let line_len = strlen(getline('.'))
	execute "normal! `>"
	let col_loc = col('.')
	execute 'normal! gv"_x'
	if line_len == col_l    execute 'normal! p'
	else 
		execute 'normal! P'
	endif
endfunction
xnoremap <silent> p :call Put_text_without_override_register()<CR>

""""""""""""""""""""""""""""""""""
""160604_矢印キーの使用禁止！！
""コマンドからHardModeとEasyModeで切り替え可能
function! HardMode ()
	noremap <Up> <Nop>
	noremap <Down> <Nop>
	noremap <Left> <Nop>
	noremap <Right> <Nop>
endfu
function! EasyMode ()
	noremap <Up> <Up>
	noremap <Down> <Down>
	noremap <Left> <Left>
	noremap <Right> <Right>
endfunc
command! HardMode call HardMode()
command! EasyMode call EasyMode()
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

""mathjax latex
nnoremap <Leader>frac i\frac{}{}<Left><Left><Left><Esc>
nnoremap <Leader>sum i\sum_{k=}^{}<Left><Left><Left><Esc>
nnoremap <Leader>int i\int_{-\infty}^{\infty}<Left><Left><Left><Esc>
nnoremap <Leader>bd i\frac{N!}{r!<Space>\(N-r\)!}<Space>\times<Space>\left(\frac{\theta}{n}\right)^r<Space>\times<Space>\left(\frac{n-\theta}{n}\right)^{N-r}<Esc>
nnoremap <Leader>pd i\frac{\lambda^ke^{-\lambda}}{k!}<Esc>

nnoremap <Leader>nbd i$$ P\left(r \right) = \frac{\left(1 + \frac{M}{K} \right)^{-K} \cdot \Gamma\left(K + r \right)}{\Gamma\left(r + 1 \right)\cdot \Gamma\left(K \right)} \cdot \left(\frac{M}{M+K} \right)^r \cdots \left(1 \right)$$<Esc>

nnoremap <Leader>dot i\,\,\,\,\cdot\cdot\cdot\cdot\,\,\,\,\left(\right)<Esc>b<Left>i<Esc>
nnoremap <Leader>$ i$\displaystyle<Space>$<Left><Esc>
nnoremap <Leader>$$ i$$<Space><Space>$$<Left><Left><Left><Esc>
nnoremap <Leader>l( i\left(<Space>\right)<Esc>F<Space>
nnoremap <Leader>l{ i\left{<Space>\right}<Esc>F<Space>
nnoremap <Leader>l[ i\left[<Space>\right]<Esc>F<Space>

nnoremap <Leader>lred i<font color="MediumVioletRed"> </font><Esc>F<Space>

nnoremap <Leader>la i\alpha<Esc>
nnoremap <Leader>lb i\bata<Esc>
nnoremap <Leader>lc i\gamma<Esc>
nnoremap <Leader>ld i\delta<Esc>
nnoremap <Leader>ll i\mu<Esc>
nnoremap <Leader>ll i\lambda<Esc>

nnoremap <Leader>lC i\Gamma<Esc>
nnoremap <Leader>lD i\Delta<Esc>

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

nnoremap <Leader>1 i<Right>第一のクライアント端末１００<Esc>
nnoremap <Leader>2 i<Right>中継サーバー２００<Esc>
nnoremap <Leader>3 i<Right>サービス提供サーバーＡ３００<Esc>
nnoremap <Leader>4 i<Right>サービス提供サーバーＢ４００<Esc>
nnoremap <Leader>5 i<Right>第二のクライアント端末５００<Esc>

""python
nnoremap <Leader>pymain iif<Space>__name__<Space>==<Space>"__main__":<Esc> 

""git 
nnoremap <Leader>gcciwip i[WIP]<Space>ci<Space>update<Esc> 
nnoremap <Leader>gcwip i[WIP]<Esc> 
nnoremap <Leader>gcu iupdate<Esc> 
nnoremap <Leader>gcm iminor<Space>modifications<Esc> 

"" ruby
nnoremap <Leader>rv i<%= %><Esc>F<Space>i 

"" coverity 修正プレフィックス 
nnoremap <Leader>cprefix i[coverity:] <Esc> 


function! Testtemp()

	""execute ":normal ciw"
	""execute	":s/_\\(.\\)/\\u\\2/g"
	""execute	":s/_\\(.\\)/\\u\\1_KEY/g"

	""Jexecute ":s/\\(.\\)/\\u\\1/g"
	""execute ":s/\\(.*\\)/\\u\\1_\\1/g"

	""execute ":'<,'>s/\\(.*\\)/\\u\\1_\\1/g"


	execute ":'<,'>s/\\([a-z].*\\)/\"\\u\\1_\\1\"/g"

	""execute	":s/_\(.\)/\u\1/g"
	""execute	":s/abc/efb/g"
	""execute	":s/_(.)/\u\1/g"
	""execute	":s/_[a-z]//g"
	""execute	":s/_.*//g"
endfunction

:command! Testtemp call Testtemp()
nmap <C-y> :Testtemp<CR>

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

" for vimdiff setting
let g:netrw_rsync_cmd = 'rsync -a --no-o --no-g --rsync-path="sudo rsync" -e "ssh -oPermitLocalCommand=no"'

" private vimrc(such as ctags, etc)

" set tags=/home/vagrant/sky/sky/log_monitoring/tags
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

