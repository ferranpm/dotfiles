try
	runtime bundle/pathogen/autoload/pathogen.vim
	execute pathogen#infect()
endtry

" QuickBuf
let g:quickbuf_map='<F2>'

" CtrlP
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=100
let g:ctrlp_max_files=100
let g:ctrlp_by_filename=1
let g:ctrlp_working_path_mode='rawc'
let g:ctrlp_use_caching=1

" Basic configuration
let mapleader=','
filetype plugin indent on
syntax on
set autochdir
set autoread
set cursorline
set encoding=utf-8
set mouse=a
set nocompatible
set number
set relativenumber
set ruler
set scrolloff=10
set showbreak=↪
set showcmd
set showmode
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc,*.tar.*,*.tgz,*.zip,*.rar,__*__

" Indentation
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab
set autoindent

" Search & Replace
set incsearch
set ignorecase
set smartcase
set gdefault

" Backups 
set noswapfile
set nobackup
set nowritebackup

" Status Line
set laststatus=2

" Menu
set wildmode=list:full
set wildmenu

" Colors
set t_Co=256
set background=dark
try
	colorscheme lucius
	highlight CursorLine cterm=Bold
	highlight Normal ctermbg=None
endtry

function! MakeTags()
	let filetype = &filetype
	let extension = expand('%:e')
	let cmd='ctags --append --recurse --languages='.filetype.' *'
	echo cmd
	let resp = system(cmd)
	if resp
		echo resp
	endif
endfunction

nmap <F8> :call MakeTags()<CR>

function! NumberToggle()
	if(&relativenumber == 1)
		set norelativenumber
	else
		set relativenumber
	endif
endfunc

nnoremap <C-c> :call NumberToggle()<cr>

nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

nnoremap <C-l> gt
nnoremap <C-h> gT

inoremap <C-n> <C-x><C-o>
inoremap <C-p> <C-x><C-p>

nnoremap <up> :move .-2<CR>
nnoremap <down> :move .+1<CR>
vnoremap <up> :move .-2<CR>gv
vnoremap <down> :move '>+<CR>gv

vnoremap > >gv
vnoremap < <gv

nnoremap <CR> o<Esc>
nnoremap <BS> O<Esc>

nnoremap <silent> <Space> i_<Esc>r
nnoremap <silent> l <Space>
nnoremap <silent> h <BS>

nnoremap <leader>. :update<CR>
nnoremap <leader>e :q<CR>
nnoremap <leader>E :qa!<CR>
nnoremap <leader>o :only<CR>
