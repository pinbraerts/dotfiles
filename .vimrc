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
set noshowmode
nohls

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_exclude_filetypes = ["terminal"]
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

" start, end = 0, -
noremap - $
vnoremap - g_

" yank to end of line
nnoremap Y yg$

" disable highlight
nnoremap <silent> <esc> <cmd>nohls<cr>
vnoremap <esc> <c-c>

" paste from clipboard while typing
inoremap <c-v> <c-c>"*pa

" replace without overriding register
vnoremap R "_dP

" enter maps
nnoremap <enter> i<cr><c-c>
nnoremap <silent> <s-enter>	       <cmd>call append(line('.')-1,'')<cr>
nnoremap <silent> <c-enter>	       <cmd>call append(line('.')  ,'')<cr>
inoremap <silent> <s-enter> <c-c>  <cmd>call append(line('.')-1,'')<cr>a
inoremap <silent> <c-enter> <c-c>  <cmd>call append(line('.')  ,'')<cr>a
vnoremap <silent> <s-enter> <c-c>`<<cmd>call append(line('.')-1,'')<cr>gv
vnoremap <silent> <c-enter> <c-c>`><cmd>call append(line('.')  ,'')<cr>gv

" move lines on alt
nnoremap <silent> <a-k>      <cmd>m-2<cr>==
nnoremap <silent> <a-j>      <cmd>m+1<cr>==
vnoremap <silent> <a-j>      <cmd>m'>+1<cr>gv=gv
vnoremap <silent> <a-k>      <cmd>m'<-2<cr>gv=gv
inoremap <silent> <a-j> <c-c><cmd>m+1<cr>==a
inoremap <silent> <a-k> <c-c><cmd>m-2<cr>==a

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
nnoremap <silent> [b <cmd>bp<cr>
nnoremap <silent> ]b <cmd>bn<cr>

" scroll quickfix
nnoremap <silent> [q <cmd>cp<cr>
nnoremap <silent> ]q <cmd>cn<cr>

" fastcmd maps
nnoremap \\ :
nnoremap \q  <cmd>q<cr>
nnoremap \w  <cmd>w<cr>
nnoremap \e  <cmd>e<cr>
nnoremap \a  <cmd>30Lex!<cr>
nnoremap \gs <cmd>vert G<cr>
nnoremap  gc <cmd>G commit<cr>
nnoremap \gp <cmd>G push<cr>
nnoremap \gP <cmd>G push --force-with-lease<cr>
nnoremap \gf <cmd>G fetch<cr>
nnoremap \gF <cmd>G fetch --all --prune<cr>
nnoremap \gu <cmd>G submodule update --recursive<cr>
nnoremap \gr :G rebase 
nnoremap \go :G checkout 

augroup single_file_launch
    au!
    au BufEnter *.vimrc nnoremap <buffer> <silent> \s <cmd>source %<cr>
    au BufEnter *nvim/*.lua nnoremap <buffer> <silent> \s <cmd>so<cr>
augroup END

function! TerminalSettings()
    setlocal nonumber
    setlocal norelativenumber
    setlocal signcolumn=no
    set ft=terminal
    " setlocal w:airline_active=0
    " setlocal laststatus=0
endfunction

augroup terminal
    au!
    au TermOpen * call TerminalSettings()
    " au TermClose * setlocal laststatus=2
    " au TermClose * let w:airline_active=0
augroup END

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
tnoremap <Esc> <C-\><C-n>
tnoremap <A-h> <C-\><C-N><C-w>h
tnoremap <A-j> <C-\><C-N><C-w>j
tnoremap <A-k> <C-\><C-N><C-w>k
tnoremap <A-l> <C-\><C-N><C-w>l
inoremap <A-h> <C-\><C-N><C-w>h
inoremap <A-j> <C-\><C-N><C-w>j
inoremap <A-k> <C-\><C-N><C-w>k
inoremap <A-l> <C-\><C-N><C-w>l
