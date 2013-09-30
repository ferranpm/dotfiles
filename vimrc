filetype off

set runtimepath+=~/.vim/bundle/vundle/
call vundle#rc()

" My Bundles here:

" original repos on github
Bundle 'bling/vim-airline'
Bundle 'garbas/vim-snipmate.git'
Bundle 'gmarik/vundle' 
Bundle 'jonathanfilip/vim-lucius'
Bundle 'kien/ctrlp.vim'
Bundle 'MarcWeber/vim-addon-mw-utils.git'
Bundle 'othree/html5.vim'
Bundle 'Rip-Rip/clang_complete'
Bundle 'scrooloose/nerdtree'
Bundle 'tek/vim-quickbuf'
Bundle 'terryma/vim-multiple-cursors'
Bundle 'tomtom/tcomment_vim'
Bundle 'tomtom/tlib_vim.git'
Bundle 'tpope/vim-fugitive'

" vim-scripts repos
Bundle 'taglist.vim'
Bundle 'php.vim-html-enhanced'

filetype on

" QuickBuf
let g:quickbuf_map='<F2>'

" CtrlP
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=100
let g:ctrlp_max_files=100
let g:ctrlp_by_filename=1
let g:ctrlp_working_path_mode='rwc'
let g:ctrlp_use_caching=1

" TagList
let Tlist_Auto_Highlight_Tag=0
let Tlist_Close_On_Select=1
let Tlist_Compact_Format=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Highlight_Tag_On_BufEnter=0
let Tlist_Show_One_File=1
let Tlist_Sort_Type='name'
let Tlist_WinWidth=75

" NERDTree
let NERDTreeWinSize=75
let NERDTreeQuitOnOpen=1
let NERDTreeChDirMode=2

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
