" Pathogen
let g:pathogen_disabled = []
try
    runtime bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry

" CtrlP
let g:ctrlp_show_hidden=0
let g:ctrlp_max_height=100
let g:ctrlp_max_files=100
let g:ctrlp_working_path_mode='rawc'
let g:ctrlp_use_caching=0

" Basic configuration
filetype plugin indent on
syntax on
let mapleader=','
set autowrite
set autoread
set encoding=utf-8
set list
set listchars=tab:\|\ ,
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
set statusline=%f\ %y%h%r%w\ (%l/%L,\ %c)\ %p%%%=%m\ %{getcwd()}

" Menu
set wildmenu
set wildmode=longest:list,full

" Colors & GUI
call matchadd('ColorColumn', '\%81v', 100)
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    if has('gui_gtk2')
    elseif has('gui_win32')
        set guifont=Consolas:h11
        colorscheme zellner
    endif
elseif has('$DISPLAY')
    colorscheme seoul
else
    colorscheme torte
endif

autocmd! InsertEnter * set number norelativenumber
autocmd! InsertLeave * set number relativenumber

autocmd! BufWritePost .vimrc so %

command! -nargs=+ -complete=command Pipe call Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call Shell(<q-args>)
command! ClearWhiteSpace :%s/ *$\|<tab>*$/
command! SudoW :w !sudo tee %

map J 5j
map K 5k

noremap <C-k> k{j
noremap <C-j> j}k

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap <silent> <up>   :move .-2<cr>
nnoremap <silent> <down> :move .+1<cr>
vnoremap <silent> <up>   :move .-2<cr>gv
vnoremap <silent> <down> :move '>+<cr>gv

nnoremap <silent> <right> :bn<cr>
nnoremap <silent> <left>  :bp<cr>

vnoremap > >gv
vnoremap < <gv

noremap ; :
noremap : ;

nnoremap Y y$
nnoremap <Space> i_<Esc>r

nnoremap <F1> :set relativenumber! relativenumber?<cr>
nnoremap <F2> :set cursorline! cursorline?<cr>
nnoremap <F3> :set hlsearch! hlsearch?<cr>
nnoremap <F4> :set spell! spell?<cr>
nnoremap <F5> :make<cr>
nnoremap <F6> :!rsync -avz -e ssh ~/SO2/zeos/ alumne@172.16.47.128:~/zeos/<cr><cr>
nnoremap <F7> :execute "!make ".expand("%:r")." && ./".expand("%:r")<cr>
nnoremap <F12> :call MakeTags(2)<cr>

noremap                <leader>c :yank +<cr>
noremap                <leader>v :put +<cr>
noremap                <leader>p :put *<cr>
noremap                <leader>j :join<cr>
nnoremap                <leader>l o<Esc>
nnoremap                <leader>L O<Esc>
nnoremap                <leader>fe zMzvzz
nnoremap                <leader>fo zR
nnoremap                <leader>fc zM
nnoremap                <leader>bc :ls!<cr>:bwipeout 
nnoremap                <leader>bs :ls!<cr>:buffer 
nnoremap    <silent>    <leader>bk :call BufferKill()<cr>
nnoremap                <leader>o :only<cr>
nnoremap    <silent>    <leader>. :update<cr>
nnoremap    <silent>    <leader>e :bwipeout<cr>
nnoremap    <silent>    <leader>q :qall<cr>

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
    call cursor(1, 1)
    execute 'delete'
    set nomodified
endfunction

function! MakeTags(...)
    call system("rm tags")
    if a:0 > 0
        let depth=a:1
    else
        let depth=1
    endif
    let path = expand('%:p:h')
    let extension = expand('%:e')
    let cmd='ctags $(find '.path.' -maxdepth '.depth.' -name "*.'.extension.'")'
    echo cmd
    call system(cmd)
endfunction

function! BufferKill()
    let l:buffers = range(1, bufnr('$'))
    let l:n = 1
    while l:n <= len(l:buffers)
        if bufexists(l:n) && !bufloaded(l:n) && !buflisted(l:n)
            execute 'bwipeout '.l:n
        endif
        let l:n += 1
    endwhile
    echo 'Unloaded buffers killed!'
endfunction
