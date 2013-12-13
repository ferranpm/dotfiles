try
    runtime bundle/pathogen/autoload/pathogen.vim
    execute pathogen#infect()
catch
endtry

" Lightline
let g:lightline = {}
let g:lightline.component = {
            \ 'lineinfo': '(%l/%L, %c) %p%%'
            \ }
let g:lightline.active = {
            \ 'left': [['relativepath'], ['filetype', 'readonly'], ['lineinfo']],
            \ 'right': [['modified']]
            \ }

" CtrlP
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=100
let g:ctrlp_max_files=100
let g:ctrlp_by_filename=1
let g:ctrlp_working_path_mode='rawc'
let g:ctrlp_use_caching=1

" Basic configuration
filetype plugin indent on
let mapleader=','
syntax on
set autoread
set cursorline
set encoding=utf-8
set nocompatible
set number
set relativenumber
set ruler
set scrolloff=10
set showbreak=>
set showcmd
set showmode
set timeoutlen=500
set ttimeoutlen=0
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc,*.tar.*,*.tgz,*.zip,*.rar,__*__

" Indentation
set autoindent
set expandtab
set shiftwidth=4
set smarttab
set softtabstop=4
set tabstop=4

" Search & Replace
set gdefault
set ignorecase
set incsearch
set smartcase

" Backups
set nobackup
set noswapfile
set nowritebackup

" Status Line
set laststatus=2
set statusline=%f\ %y%h%r%w\ (%l/%L,\ %c)\ %p%%%=%m

" Menu
set wildmenu
set wildmode=list:full

" Colors
try
    colorscheme seoul
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

nmap <F8> :call MakeTags()<cr>

function! Number()
    set norelativenumber
    set number
endfunction

function! RelativeNumber()
    set number
    set relativenumber
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

nnoremap <up> :move .-2<cr>
nnoremap <down> :move .+1<cr>
vnoremap <up> :move .-2<cr>gv
vnoremap <down> :move '>+<cr>gv

nnoremap <silent> <right> :bn<cr>
nnoremap <silent> <left> :bp<cr>

vnoremap > >gv
vnoremap < <gv

nnoremap <cr> o<Esc>
nnoremap <bs> O<Esc>

nnoremap <silent> l <Space>
nnoremap <silent> h <bs>

nnoremap Y y$
nnoremap <silent> <Space> i_<Esc>r

nnoremap <leader>. :update<cr>
nnoremap <leader>e :q<cr>
nnoremap <leader>E :qa!<cr>
nnoremap <leader>o :only<cr>
