call pathogen#infect()

" C and C++ completion
let g:clang_library_path='/usr/lib/llvm/'
let g:clang_use_librar=1

" QuickBuf
let g:qb_hotkey = '<F2>'

" CtrlP
let g:ctrlp_show_hidden = 1
let g:ctrlp_max_height = 100
let g:ctrlp_max_files = 2500
let g:ctrlp_by_filename = 1

let mapleader = ','

syntax on
filetype plugin indent on

set number
set autoread
set gdefault
set ruler
set showcmd
set showmode
set incsearch
set ignorecase
set smartcase
set nohlsearch
set noerrorbells
set visualbell
set mouse=a
set scrolloff=5

set encoding=utf-8

set expandtab
set smarttab
set tabstop=2
set autoindent
set shiftwidth=2

set wrap

set laststatus=2
set nocompatible

set wildmenu
set wildmode=list:full

set noswapfile
set nobackup
set nowritebackup

set statusline=%F%m%r%h%w\ type=%Y\ x=%l\ y=%v\ %p%%\ %{strftime(\"%d/%m/%y\ -\%H:%M\")}
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc

" Tancar la finestra d'ajuda de Omni-Completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType python set omnifunc=pythoncomplete#Complete
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags

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

noremap <leader>, :update<CR>
noremap <leader>e :q<CR>
noremap <leader>E :qa!<CR>
nnoremap <F1> :NERDTree<CR>
nnoremap <silent> <F5> :wa<CR>:!make && make run<CR>
nnoremap <silent> <Space> i_<Esc>r
inoremap <C-n> <C-x><C-o>
inoremap <C-p> <C-x><C-p>

nnoremap <silent> <leader>y :call Copy()<CR>
vnoremap <silent> <leader>y :call Copy()<CR>
nnoremap <silent> <leader>p :call Paste()<CR>
vnoremap <silent> <leader>p :call Paste()<CR>

let g:reg_file = '/home/ferran/.vim/reg'

function! Copy()
  let l = line('.')
  call SaveLines(l, l)
endfunction

function! Copy() range
  call SaveLines(a:firstline, a:lastline)
endfunction

function! SaveLines(a, b)
  let text = getline(a:a, a:b)
  call writefile(text, g:reg_file)
  echo 'COPIAT!'
endfunction

function! Paste()
  let text = readfile(g:reg_file)
  call append(line('.'), text)
  echo 'ENGANXAT!'
endfunction
