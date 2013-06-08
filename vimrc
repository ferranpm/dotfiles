call pathogen#infect()

" C and C++ completion
let g:clang_library_path='/usr/lib/llvm/'
let g:clang_use_librar=1

" QuickBuf
let g:qb_hotkey='<F2>'

" CtrlP
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=100
let g:ctrlp_max_files=2500
let g:ctrlp_by_filename=1

" taglist
let Tlist_Auto_Highlight_Tag = 0
let Tlist_Close_On_Select=1
let Tlist_Compact_Format=1
let Tlist_GainFocus_On_ToggleOpen=1
let Tlist_Highlight_Tag_On_BufEnter = 0
let Tlist_Show_One_File=1
let Tlist_Sort_Type = "name"
let Tlist_WinWidth=75

" NERDTree
let NERDTreeWinSize=75
let NERDTreeQuitOnOpen=1
let NERDTreeMinimalUI=1

let mapleader=','

syntax on
filetype plugin indent on

colorscheme gruvbox

set number
set ruler

set autoread
set gdefault
set showcmd
set showmode
set incsearch
set ignorecase
set smartcase
set nohlsearch
set mouse=a
set scrolloff=10

set encoding=utf-8

set expandtab
set smarttab
set tabstop=2
set autoindent
set shiftwidth=2

set laststatus=2
set nocompatible

set wildmenu
set wildmode=list:full

set noswapfile
set nobackup
set nowritebackup

set statusline=%F%m%r%h%w\ type=%Y\ x=%l\ y=%v\ %p%%\ %{strftime(\"%d/%m/%y\ -\%H:%M\")}
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc

set showbreak=↪
set foldmethod=indent
set foldlevelstart=99


set cursorline
if has("gui_running")
  highlight CursorLine cterm=bold ctermbg=black
else 
  highlight CursorLine cterm=bold ctermbg=black ctermfg=None guibg=None guifg=None
endif

" Tancar la finestra d'ajuda de Omni-Completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete

nnoremap j gj
nnoremap k gk
xnoremap j gj
xnoremap k gk

nmap J 5j
nmap K 5k
xmap J 5j
xmap K 5k

nmap gh <C-w>h
nmap gj <C-w>j
nmap gk <C-w>k
nmap gl <C-w>l

nmap <C-l> gt
nmap <C-h> gT

imap <leader>' ''<Esc>i
imap <leader>" ""<Esc>i
imap <leader>( ()<Esc>i
imap <leader>[ []<Esc>i
imap <leader>{ {}<Esc>i

nmap <down> ddp
nmap <up> ddkP

nnoremap <leader><leader> :update<CR>
nnoremap <leader>e :q<CR>
nnoremap <leader>E :qa!<CR>
nnoremap <leader>o :only<CR>
nnoremap <silent> <C-g> :TlistToggle<CR>
nnoremap <silent> <C-f> :NERDTreeToggle<CR>
nnoremap <silent> <Space> i_<Esc>r
inoremap <C-n> <C-x><C-o>
inoremap <C-p> <C-x><C-p>
