scriptencoding utf-8
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
set shiftwidth=2
set splitright
set tabstop=2
nohls

if exists(":GuiFont")
	GuiFont! JetBrains Mono:h11
endif

let g:netrw_banner = 0
let g:netrw_liststyle = 3
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = ''
let g:airline#extensions#tabline#buffer_min_count = 2
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_section_b = '%{strftime("%H:%M")}'
let g:NERDCreateDefaultMappings = 0
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1
let g:NERDDefaultAlign = 'left'
let g:NERDCommentEmptyLines = 1
let g:NERDTrimTrailingWhitespace = 1
let g:NERDToggleCheckAllLines = 1

 noremap <a-w> /\u<cr>
 noremap <a-b> ?\u<cr>
nnoremap Y yg$
nnoremap <silent> <esc> :nohls<cr>
inoremap <c-v> <c-c>"*pa
inoremap jk <esc>
vnoremap R "_dP
nnoremap <c-j> kJ
nnoremap gr gT

nnoremap <enter> i<cr><c-c>
nnoremap <silent> <s-enter>	       :call append(line('.')-1,'')<cr>
nnoremap <silent> <c-enter>	       :call append(line('.')  ,'')<cr>
inoremap <silent> <s-enter> <c-c>  :call append(line('.')-1,'')<cr>a
inoremap <silent> <c-enter> <c-c>  :call append(line('.')  ,'')<cr>a
vnoremap <silent> <s-enter> <c-c>`<:call append(line('.')-1,'')<cr>gv
vnoremap <silent> <c-enter> <c-c>`>:call append(line('.')  ,'')<cr>gv

nnoremap <silent> <a-k>      :m-2<cr>==
nnoremap <silent> <a-j>      :m+1<cr>==
vnoremap <silent> <a-j>      :m'>+1<cr>gv=gv
vnoremap <silent> <a-k>      :m'<-2<cr>gv=gv
inoremap <silent> <a-j> <c-c>:m+1<cr>==a
inoremap <silent> <a-k> <c-c>:m-2<cr>==a

onoremap aq a"
onoremap iq i"
xnoremap aq a"
xnoremap iq i"
nnoremap dq va"

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

nnoremap q <nop>
nnoremap qq q
nnoremap <silent> qw :bdelete!<cr>
nnoremap <silent> qe :close!<cr>
nnoremap <silent> qr :tabclose!<cr>
nnoremap <silent> qt :q<cr>
nnoremap <silent> qy :wqa<cr>
nnoremap \ i<space><c-c>r

let mapleader=" "
nnoremap <silent> <leader>m :call ToggleStyle()<cr>
nnoremap <silent> <leader>1 :vsplit $MYVIMRC<cr>
nnoremap <silent> <leader>2 :w<bar>:source %<cr>
nnoremap <silent> <leader>3 :w<bar>:!%<cr>
nnoremap <silent> <leader>4 :w<bar>:silent !%<cr>
nnoremap <leader>w <c-w>
 noremap <leader>p "*p
 noremap <leader>P "*P
 noremap <leader>y "*y
 noremap <leader>Y "*Y

