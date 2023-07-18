scriptencoding utf-8
language en_US.utf8
filetype plugin indent on
syntax on
let &t_EI = "\e[2 q"
let &t_SI = "\e[6 q"
let &t_SR = "\e[4 q"
set t_RV=
set t_u7=
set autoindent
set encoding=utf-8
set ff=unix
set hlsearch
set ignorecase
set incsearch
set showmatch
set smartcase
set smartindent
set listchars=space:.,eol:$,trail:-,tab:\|\ 
set nocompatible
set noswapfile
set nowrap
set number
set relativenumber
set splitright
set shiftwidth=4
set tabstop=4
set expandtab
set scrolloff=10
set signcolumn=yes
nohls

function! SetCmd()
	let &shell="cmd"
	let &shellcmdflag="/c"
	let &shellredir='>%s 2>&2'
	set shellquote= shellxescape=
	set shellxquote=
	let $TMP="C:\\tmp"
endfunction

function! SetPwsh()
	let &shell = executable('pwsh') ? 'pwsh' : 'powershell'
	let &shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
	let &shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	let &shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
	set shellquote= shellxquote=
endfunction

function! SetShell()
	let &shell="sh"
	let &shellcmdflag="-c"
	let &shellredir='>%s 2>&2'
	set shellquote= shellxescape=
	set shellxquote=
	" let $TMP="~/AppData/Local/Temp"
	let $TMP="/tmp"
endfunction

if exists(":GuiFont")
	GuiFont! JetBrains Mono:h11
endif

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

" camel case word
 noremap <silent> <a-w> /\u<cr>
 noremap <silent> <a-b> ?\u<cr>

 " yank to end of line
nnoremap Y yg$

" disable highlight
nnoremap <silent> <esc> :nohls<cr>
vnoremap <esc> <c-c>

" paste from clipboard while typing
inoremap <c-v> <c-c>"*pa

" replace without overriding register
vnoremap R "_dP

" enter maps
nnoremap <enter> i<cr><c-c>
nnoremap <silent> <s-enter>	       :call append(line('.')-1,'')<cr>
nnoremap <silent> <c-enter>	       :call append(line('.')  ,'')<cr>
inoremap <silent> <s-enter> <c-c>  :call append(line('.')-1,'')<cr>a
inoremap <silent> <c-enter> <c-c>  :call append(line('.')  ,'')<cr>a
vnoremap <silent> <s-enter> <c-c>`<:call append(line('.')-1,'')<cr>gv
vnoremap <silent> <c-enter> <c-c>`>:call append(line('.')  ,'')<cr>gv

" move lines on alt
nnoremap <silent> <a-k>      :m-2<cr>==
nnoremap <silent> <a-j>      :m+1<cr>==
vnoremap <silent> <a-j>      :m'>+1<cr>gv=gv
vnoremap <silent> <a-k>      :m'<-2<cr>gv=gv
inoremap <silent> <a-j> <c-c>:m+1<cr>==a
inoremap <silent> <a-k> <c-c>:m-2<cr>==a

" select double quotes
onoremap aq a"
onoremap iq i"
xnoremap aq a"
xnoremap iq i"

function! ToggleStyle()
	if &list
		set colorcolumn=
	else
		set colorcolumn=80
	endif
	set invcursorline
	set invcursorcolumn
	set invlist
endfunction

let mapleader=" "
nnoremap <silent> <leader>= <cmd>call ToggleStyle()<cr>
nnoremap <silent> <leader>; A;<c-c>
nnoremap <silent> <leader>, A,<c-c>

" clipboard maps
 noremap <leader>p "*p
 noremap <leader>P "*P
 noremap <leader>y "*y
 noremap <leader>Y "*Y

" scroll buffers
nnoremap <silent> [b :bp<cr>
nnoremap <silent> ]b :bn<cr>

" scroll quickfix
nnoremap <silent> [q :cp<cr>
nnoremap <silent> ]q :cn<cr>

" fastcmd maps
nnoremap \ :
nnoremap <silent> \q :q<cr>
nnoremap <silent> \w :w<cr>
nnoremap <silent> \e :e<cr>
nnoremap <silent> \s :so<cr>
nnoremap <silent> \a :Lex<cr>
nnoremap <silent> \G :G<cr>
nnoremap <silent> \gs :vert G<cr>
nnoremap <silent> \gc :G commit<cr>
nnoremap <silent> \gp :G push<cr>
nnoremap <silent> \gP :G push --force-with-lease<cr>
nnoremap <silent> \gf :G fetch --all --prune<cr>
nnoremap \gr :G rebase 

" window maps
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

" command line remaps
cnoremap <c-h> <left>
cnoremap <c-j> <down>
cnoremap <c-k> <up>
cnoremap <c-l> <right>
