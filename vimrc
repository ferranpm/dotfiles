" Vundle
set nocompatible
filetype off
try
    set runtimepath+=~/.vim/bundle/Vundle.vim
    call vundle#begin()
catch
endtry
if exists(':Plugin')
    Plugin 'christoomey/vim-tmux-navigator'
    Plugin 'gmarik/Vundle.vim'
    Plugin 'ctrlpvim/ctrlp.vim'
    Plugin 'ludovicchabant/vim-gutentags'
    Plugin 'taku-o/vim-vis'
    Plugin 'tpope/vim-commentary'
    Plugin 'tpope/vim-dispatch'
    Plugin 'tpope/vim-fugitive'
    Plugin 'tpope/vim-repeat'
    Plugin 'tpope/vim-surround'
    if has('python')
        Plugin 'vim-scripts/UltiSnips'
    endif
endif
try
    call vundle#end()
catch
endtry

if filereadable(expand('~/.local.vim'))
    source ~/.local.vim
endif

" Basic configuration
" important
set nocompatible

" moving around, searching and patterns
set incsearch
set ignorecase
set smartcase

" tags

" displaying text
set scrolloff=4
set showbreak=>
set list
set listchars=tab:»\ ,trail:·
set number
set relativenumber
set nowrap

" syntax, highlighting and spelling
set background=dark
set t_Co=256
set nohlsearch

" multiple windows
set laststatus=2
set statusline=%f%m\ %y%h%r%w\ (%l/%L,\ %c)\ %p%%\ %=%{substitute(getcwd(),'^'.$HOME,'~','')}
set hidden
set switchbuf=useopen
set splitbelow
set splitright

" multiple tab pages

" terminal
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\'%:~:.:h\')})%)%(\ %a%)

" using the mouse

" GUI
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set columns=9999
    set lines=9999
    set showtabline=2
    if has('win32')
        set guifont=Consolas:h10
    endif
endif

" printing

" messages and info
set showcmd
set showmode
set ruler
set confirm

" selecting text

" editing text
set backspace=2
set completeopt=menuone

" tabs and indenting
set shiftwidth=4
set smarttab
set expandtab
set autoindent
set smartindent

" folding
set foldlevel=1
set foldcolumn=1
set foldopen=hor,mark,percent,quickfix,search,tag,undo
set foldmethod=syntax
set foldnestmax=1

" diff mode

" mapping
set timeoutlen=500
set ttimeoutlen=0

" reading and writing files
set modeline
set autoread
set nowritebackup
set nobackup

" the swap file
set noswapfile

" command line editing
set wildmode=longest:list,full
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc,*.tar.*,*.tgz,*.zip,*.rar,__*__
set wildignorecase
set wildmenu

" executing external commands

" running make and jumping to errors
if has('unix')
    set grepprg=ack\ -i
else
    set makeprg=mingw32-make\ -j8
    set grepprg=grep\ -ri
endif

" language specific

" multi-byte characters
set termencoding=utf8
set encoding=utf-8

" various
set virtualedit=block
set exrc
set gdefault

" misc
let mapleader=' '
filetype plugin on
filetype indent on
syntax on
try
    colorscheme xoria256
catch
endtry

" Autocommands
augroup autocommands
    autocmd! VimResized * :wincmd =
    autocmd! QuickFixCmdPost * :cwindow
augroup END
