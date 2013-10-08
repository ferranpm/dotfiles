runtime bundle/pathogen/autoload/pathogen.vim
execute pathogen#infect()

" QuickBuf
let g:quickbuf_map='<F2>'

" CtrlP
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=100
let g:ctrlp_max_files=100
let g:ctrlp_by_filename=1
let g:ctrlp_working_path_mode='rwc'
let g:ctrlp_use_caching=1

" AirLine
let g:airline_left_sep=''
let g:airline_right_sep=''
let g:airline_theme='powerlineish'

" C and C++
let g:clang_use_librar=1
let g:clang_complete_auto=1
let g:clang_snippets=1
let g:clang_close_preview=1

" Basic configuration
let mapleader=','
filetype plugin indent on
syntax on
set mouse=a
set scrolloff=10
set encoding=utf-8
set showbreak=↪
set nocompatible
set number
set ruler
set autoread
set showcmd
set showmode
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc,*.tar.*,*.tgz,*.zip,*.rar,__*__

" Indentation
set tabstop=2
set shiftwidth=2
set smarttab
set autoindent

" Search & Replace
set incsearch
set ignorecase
set smartcase
set cursorline
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
colorscheme lucius
highlight CursorLine cterm=Bold
highlight Normal ctermfg=253 ctermbg=None
highlight Comment ctermfg=65
highlight TabLine ctermfg=12 ctermbg=232
highlight TabLineSel ctermfg=22 ctermbg=148
highlight TabLineFill ctermbg=237

nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

nmap J 10j
nmap K 10k
xmap J 10j
xmap K 10k

nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

nmap <C-l> gt
nmap <C-h> gT

imap <C-n> <C-x><C-o>
imap <C-p> <C-x><C-p>

nmap <down> ddp
nmap <up> ddkP

nnoremap <CR> o<Esc>
nnoremap <BS> O<Esc>

nnoremap <leader>. :update<CR>
nnoremap <leader>e :q<CR>
nnoremap <leader>E :qa<CR>
nnoremap <leader>o :only<CR>
nnoremap <silent> <Space> i_<Esc>r
