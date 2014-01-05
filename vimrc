" Pathogen
let g:pathogen_disabled = []
try
    runtime bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry

" CtrlP
let g:ctrlp_show_hidden=1
let g:ctrlp_max_height=100
let g:ctrlp_max_files=100
let g:ctrlp_working_path_mode='rawc'
let g:ctrlp_use_caching=1

" Basic configuration
filetype plugin indent on
syntax on
let mapleader=','
set autoread
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

" Windows & splits
set splitright
set nosplitbelow

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

" Folds
set foldmethod=indent
set foldnestmax=1
set foldcolumn=1
set foldlevel=1

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
try
    if exists("$DISPLAY")
        colorscheme seoul
    else
        colorscheme torte
    endif
catch
endtry

autocmd InsertEnter * :set number norelativenumber
autocmd InsertLeave * :set number relativenumber

command! -nargs=+ -complete=command Pipe call Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call Shell(<q-args>)
command! ClearWhiteSpace :%s/ *$\|<tab>*$/

map J 5j
map K 5k

noremap { k{<Space>
noremap } }<Space>

noremap <C-k> {)
noremap <C-j> }k

nnoremap gh <C-w>h
nnoremap gj <C-w>j
nnoremap gk <C-w>k
nnoremap gl <C-w>l

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap <silent> <up>   :move .-2<cr>
nnoremap <silent> <down> :move .+1<cr>
vnoremap <silent> <up>   :move .-2<cr>gv
vnoremap <silent> <down> :move '>+<cr>gv

nnoremap <silent> <right> :bn<cr>
nnoremap <silent> <left>  :bp<cr>

noremap <C-left> 5<c-w>>
noremap <C-right> 5<c-w><

vnoremap > >gv
vnoremap < <gv

noremap ; :
noremap : ;

nnoremap Y y$
nnoremap <Space> i_<Esc>r

nnoremap <F1> :set relativenumber! relativenumber?<cr>
nnoremap <F3> :set hlsearch! hlsearch?<cr>
nnoremap <F8> :set spell! spell?<cr>
nnoremap <F12> :call MakeTags()<cr>

 noremap             	<leader>c :yank +<cr>
 noremap             	<leader>v :put +<cr>
 noremap             	<leader>p :put *<cr>
nnoremap                <leader>l o<Esc>
nnoremap                <leader>L O<Esc>
nnoremap                <leader>f :e <C-r>=expand(getcwd()).'/'<cr>
nnoremap                <leader>fe zMzvzz
nnoremap                <leader>fo zR
nnoremap                <leader>fc zM
nnoremap                <leader>bc :ls!<cr>:bwipeout 
nnoremap                <leader>bs :ls!<cr>:buffer 
nnoremap            	<leader>o :only<cr>
nnoremap    <silent>	<leader>. :update<cr>
nnoremap    <silent>	<leader>e :quit<cr>
nnoremap    <silent>	<leader>q :qall<cr>

function! Pipe(cmd)
    redir @+>
    silent execute a:cmd
    redir END
    vnew
    silent 0put +
    set nomodified
endfunction

function! Shell(cmd)
    vnew
    execute 'read !'.a:cmd
    set nomodified
endfunction

function! MakeTags(...)
    if a:0 > 0
        let depth=a:1
    else
        let depth=2
    endif
    let extension = expand('%:e')
    let cmd='ctags $(find $(pwd) -maxdepth '.depth.' -name "*.'.extension.'")'
    echo cmd
    call system(cmd)
endfunction
