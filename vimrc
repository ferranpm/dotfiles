let pathogen=expand("~/.vim/bundle/pathogen/autoload/pathogen.vim")
if filereadable(pathogen)
	runtime bundle/pathogen/autoload/pathogen.vim
	execute pathogen#infect()
endif

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
set autoread
set encoding=utf-8
set nocompatible
set number
set relativenumber
set ruler
set scrolloff=10
set showbreak=↪
set showcmd
set showmode
set timeoutlen=500
set ttimeoutlen=0
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
set statusline=%<%F%h%m%r%w%y\ (%l/%L,\ %c)\ %p%%

" Menu
set wildmode=list:full
set wildmenu

" Colors
set t_Co=256
set background=dark
try
	colorscheme lucius
	set cursorline
	highlight Normal ctermbg=None
	highlight CursorLine cterm=Bold
	highlight StatusLine ctermbg=157
	autocmd InsertEnter * highlight StatusLine ctermbg=45
	autocmd InsertLeave * highlight StatusLine ctermbg=157
catch
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

function! Number()
	set norelativenumber
	set number
endfunction

function! RelativeNumber()
	set relativenumber
	set number
endfunction

function! NumberToggle()
	if(&relativenumber == 1)
		call Number()
	else
		call RelativeNumber()
	endif
endfunc

nnoremap <silent> <C-c> :call NumberToggle()<cr>

autocmd InsertEnter * call Number()
autocmd InsertLeave * call RelativeNumber()

nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

nmap <silent> J 5j
nmap <silent> K 5k
xmap <silent> J 5j
xmap <silent> K 5k

nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap <up> :move .-2<CR>
nnoremap <down> :move .+1<CR>
vnoremap <up> :move .-2<CR>gv
vnoremap <down> :move '>+<CR>gv

nnoremap <silent> <right> :bn<CR>
nnoremap <silent> <left> :bp<CR>

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
