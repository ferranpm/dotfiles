" Added by oh-my-vim
" Change the default leader
" let mapleader = ","
" Skip upgrade of oh-my-vim itself during upgrades
let g:ohmyvim_skip_upgrade=1
" Use :OhMyVim profiles to list all available profiles with a description
" let profiles = ['defaults', 'django', 'erl', 'friendpaste', 'git', 'makefile', 'map', 'pyramid', 'python', 'ranger', 'tmpl', 'utf8']
let profiles = ['defaults']
" Path to oh-my-vim binary (take care of it if you are using a virtualenv)
let g:ohmyvim="~/.oh-my-vim/env/bin/oh-my-vim"
" load oh-my-vim
source ~/.vim/ohmyvim/ohmyvim.vim
" End of oh-my-vim required stuff
" Put your custom stuff bellow

" C and C++ completion
let g:clang_library_path="/usr/lib/llvm/"
let g:clang_use_librar=1

" NERDTree ignore list
let NERDTreeIgnore = ['\.pyc$', '\.o$', '\.class$']

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

" Tancar la finestra d'ajuda de Omni-Completion
autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
autocmd InsertLeave * if pumvisible() == 0|pclose|endif

autocmd FileType java set omnifunc=javacomplete#Complete
autocmd FileType javascript set omnifunc=javascriptcomplete#CompleteJS
autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
autocmd FileType css set omnifunc=csscomplete#CompleteCSS
autocmd FileType php set omnifunc=phpcomplete#CompletePHP

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

nnoremap <F1> :NERDTree<CR>
nnoremap <F5> :wa<CR>:!make && make run<CR>
nnoremap <Left> :bp<CR>
nnoremap <Right> :bn<CR>
nnoremap <Space> i_<Esc>r
inoremap <C-n> <C-x><C-o>
inoremap <C-p> <C-x><C-p>

nnoremap <silent> ,y Du:new<CR>:put!<CR>Gdd:wq! ~/.vim/reg<CR>
nnoremap <silent> ,p :sview ~/.vim/reg<CR>dG:q!<CR>p
vnoremap <silent> ,y :yank<CR>:new<CR>:put<CR>ggdd:wq! ~/.vim/reg<CR>
vnoremap <silent> ,p :sview ~/.vim/reg<CR>vG:yank:q!<CR>vp<Esc>
