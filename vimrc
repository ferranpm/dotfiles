call pathogen#infect()

" QuickBuf
let g:qb_hotkey='<F2>'

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

" UltiSnips
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" C and C++
let g:clang_use_librar=1
let g:clang_complete_auto=1
let g:clang_snippets=1
let g:clang_snippets_engine='ultisnips'
let g:clang_close_preview=1

" Python-mode
let pymode_folding=0
let pymode_doc=0

" Basic configuration
let mapleader=','
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
syntax on
filetype plugin indent on

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

" Tancar la finestra d'ajuda de Omni-Completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd BufRead *.less set ft=css

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
nnoremap <silent> <C-g> :TlistToggle<CR>
nnoremap <silent> <C-f> :NERDTreeToggle<CR>
nnoremap <silent> <Space> i_<Esc>r
