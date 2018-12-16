syntax on
set number
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set cursorline
set hlsearch
set scrolloff=5
set encoding=utf-8
set clipboard=unnamed

nnoremap <ESC><ESC> :nohlsearch<CR>
nnoremap O :<C-u>call append(expand('.'), '')<Cr>j

colorscheme lucius

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
""160728_
noremap j gj
noremap k gk
noremap <S-h>   ^
noremap <S-j>   }
noremap <S-k>   {
noremap <S-l>   $
noremap m  % 
nnoremap <CR> A<CR><ESC>
nnoremap == gg=G''

"" 180410 0レジスタに切り取り、無名レジスタの値をペースト
nnoremap <C-p>  diw"0p
nnoremap <C-S-P>  diw"0P

inoremap <silent> pp "0P

nnoremap <Space>n  :NERDTree<CR>
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
""inoremap { {}<Left><CR><ESC><S-o>
""inoremap ( ()<ESC>i
inoremap <C-v> <ESC>"*pa
""ダブルクオテーションを二つ付加し、カーソルを戻す
""inoremap " ""<ESC>ha

""180427_レジスタ０の内容をコピペする
""https://qiita.com/ykyk1218/items/8f5471c5e90cc83fd407
""noremap pp "0p
""noremap PP "0P

"" 括弧の自動補完
"" inoremap {<Enter> {}<Left><CR><ESC><S-o>
"" inoremap [<Enter> []<Left><CR><ESC><S-o>
"" inoremap (<Enter> ()<Left><CR><ESC><S-o>

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

""検索語が画面の真ん中に来るようにする
nmap n nzz 
nmap N Nzz 
nmap * *zz 
nmap # #zz 
nmap g* g*zz 
nmap g# g#zz

""python execute
noremap <F1> <ESC>:source ~/.vimrc<CR>
inoremap <F1> <ESC>:source ~/.vimrc<CR>

""python execute
noremap <F5> <ESC>:wa<CR>:!python %<CR>
inoremap <F5> <ESC>:wa<CR>:!python %<CR>

""ruby execute
noremap <F8> <ESC>:wa<CR>:!ruby %<CR>
inoremap <F8> <ESC>:wa<CR>:!ruby %<CR>

""bash execute
noremap <F9> <ESC>:wa<CR>:!bash exec.sh<CR>
inoremap <F9> <ESC>:wa<CR>:!bash exec.sh<CR>

let mapleader = "\<Space>"
nnoremap <Leader>s" ciw""<Esc>P
nnoremap <Leader>s' ciw''<Esc>P
nnoremap <Leader>s` ciw``<Esc>P
nnoremap <Leader>s( ciw()<Esc>P
nnoremap <Leader>s{ ciw{}<Esc>P
nnoremap <Leader>s[ ciw[]<Esc>P

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