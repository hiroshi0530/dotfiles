syntax on

set number
set mouse=a
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set smartindent
set shiftwidth=2
set cursorline
set hlsearch
set scrolloff=5
set encoding=utf-8
set clipboard=unnamed,autoselect
set expandtab

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
""inoremap { {}<Left><CR><ESC><S-o>
""inoremap ( ()<ESC>i
inoremap <C-v> <ESC>"*pa
""ダブルクオテーションを二つ付加し、カーソルを戻す
""inoremap " ""<ESC>ha

""180427_レジスタ０の内容をコピペする
""https://qiita.com/ykyk1218/items/8f5471c5e90cc83fd407
""noremap pp "0p
""noremap PP "0P

" 括弧の自動補完
" inoremap {<Enter> {}<Left><CR><ESC><S-o>
inoremap {<Enter> {}<Left><CR><ESC><Left>xx<S-o>
inoremap [<Enter> []<Left><CR><ESC>
inoremap (<Enter> ()<Left><CR><ESC>

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

""load vimrc
noremap <F1> <ESC>:source ~/.vimrc<CR>
inoremap <F1> <ESC>:source ~/.vimrc<CR>

""java execute
noremap <F3> <ESC>:wa<CR>:!javac %<CR>
inoremap <F3> <ESC>:wa<CR>:!javac %<CR>

""java build
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


""python
nnoremap <Leader>pymain iif<Space>__name__<Space>==<Space>"__main__":<Esc> 

""git 
nnoremap <Leader>gcciwip i[WIP]<Space>ci<Space>update<Esc> 
nnoremap <Leader>gcwip i[WIP]<Esc> 
nnoremap <Leader>gcu iupdate<Esc> 
nnoremap <Leader>gcm iminor<Space>modifications<Esc> 

"" ruby
nnoremap <Leader>rv i<%= %><Esc>F<Space>i 

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

" 190116: private vimrc(such as ctags, etc)

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
