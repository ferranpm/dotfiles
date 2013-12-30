" Pathogen
let g:pathogen_disabled = []
try
    runtime bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry

" Lightline
let g:lightline = {}
let g:lightline.component = {
            \ 'lineinfo': '(%l/%L, %c) %p%%',
            \ 'cwd': '%{getcwd()}'
            \ }
let g:lightline.active = {
            \ 'left': [['relativepath'], ['filetype', 'readonly'], ['lineinfo']],
            \ 'right': [['modified'], ['cwd']]
            \ }
let g:lightline.inactive = g:lightline.active

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
set mouse=n
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
set statusline=%f\ %y%h%r%w\ (%l/%L,\ %c)\ %p%%%=%{getcwd()}%m

" Menu
set wildmenu
set wildmode=longest:list,full

" Colors
call matchadd('ColorColumn', '\%81v', 100)
if exists("$DISPLAY")
    try
        colorscheme seoul
    catch
    endtry
endif

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

noremap j gj
noremap k gk

map J 5j
map K 5k

noremap { k{<Space>
noremap } }<Space>

noremap [ {)
noremap ] }k

nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap <silent> <up> :move .-2<cr>
nnoremap <silent> <down> :move .+1<cr>
vnoremap <silent> <up> :move .-2<cr>gv
vnoremap <silent> <down> :move '>+<cr>gv

nnoremap <silent> <right> :bn<cr>
nnoremap <silent> <left> :bp<cr>

vnoremap > >gv
vnoremap < <gv

noremap ; :
noremap : ;

nnoremap <leader>l o<Esc>
nnoremap <leader>L O<Esc>

noremap l <Space>
noremap h <bs>

nnoremap Y y$
nnoremap <Space> i_<Esc>r

nnoremap <silent> <leader>. :update<cr>
nnoremap <silent> <leader>e :q<cr>
nnoremap <silent> <leader>q :qa<cr>
nnoremap <silent> <leader>o :only<cr>

function! Pipe(cmd)
    redir @+>
    silent execute a:cmd
    redir END
    vnew
    silent 0put +
    set nomodified
endfunction

command! -nargs=+ -complete=command Pipe call Pipe(<q-args>)

command! ClearWhiteSpace :%s/ *$\|<tab>*$/
