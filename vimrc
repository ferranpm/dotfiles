" Pathogen
if !has("python")
    let g:pathogen_disabled = ["ultisnips", "Omnisharp"]
endif
try
    runtime bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry

" Netrw
let g:netrw_banner=0
let g:netrw_liststyle=1
let g:netrw_keepdir=1

" UltiSnips
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'

" CtrlP
let g:ctrlp_show_hidden=0
let g:ctrlp_max_height=100
let g:ctrlp_max_files=100
let g:ctrlp_working_path_mode='rawc'
let g:ctrlp_use_caching=0

" Basic configuration
filetype plugin on
filetype indent on
syntax on
let mapleader=','
set autoread
set backspace=2
set encoding=utf-8
set grepprg=ack
set isfname-==
set mouse=n
set nocompatible
set scrolloff=10
set timeoutlen=500
set ttimeoutlen=0
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc,*.tar.*,*.tgz,*.zip,*.rar,__*__

" Indicators
set completeopt=menuone
set number
set relativenumber
set ruler
set showbreak=>
set showcmd
set showmode
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\'%:~:.:h\')})%)%(\ %a%)

" Windows & splits
set splitright
set nosplitbelow

" Indentation
set autoindent
set expandtab
set list
set listchars=tab:\|\ ,trail:·
set shiftwidth=4
set smartindent
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
set foldtext=NeatFoldText()

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
if has('gui_running')
    try
        colorscheme lucius
    catch
    endtry
    set background=dark
" Highlights
highlight WhiteOnRed ctermfg=255 ctermbg=196 guifg=#ffffff guibg=#ff0000
highlight IndentWhiteSpaces cterm=undercurl ctermfg=235 gui=underline guifg=#262626
highlight TrilingWhitespace ctermbg=199 guibg=#ff00af
highlight RightMargin ctermbg=93 guibg=#8700ff
call matchadd('RightMargin', '\%81v', 30)
call matchadd('TrilingWhitespace', '\s\+\%#\@<!$', 70)
call matchadd('IndentWhiteSpaces', '^ \+', 100)
    set guioptions-=m
    set guioptions-=T
    set columns=120
    set lines=9999
    set showtabline=2
    if has('unix')
        set guifont=Monospace
    elseif has('win32')
        set guifont=Consolas:h9
    endif
else
    if has('unix')
        try
            colorscheme seoul
        catch
        endtry
    endif
endif

" Autocommands
if has('autocmd')
    autocmd! InsertEnter * set norelativenumber number
    autocmd! InsertLeave * set relativenumber
    autocmd! FileType * setlocal formatoptions=ql
endif

" Commands
command! -nargs=+ -complete=command Pipe call Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call Shell(<q-args>)
command! -nargs=1 -complete=help Help if &filetype=="help" | help <args> | else | tab help <args> | endif
command! Sudo %!sudo tee > /dev/null %

" Mappings
nmap J 5j
nmap K 5k

xmap J 5j
xmap K 5k

vmap Q gq
nmap Q gqap

inoremap <C-o> <C-x><C-o><C-p>

nnoremap <C-l> gt
nnoremap <C-h> gT

nnoremap <silent> <up>   :move .-2<cr>
nnoremap <silent> <down> :move .+1<cr>
vnoremap <silent> <up>   :move .-2<cr>gv
vnoremap <silent> <down> :move '>+<cr>gv

nnoremap <silent> <right> :bn<cr>
nnoremap <silent> <left>  :bp<cr>

nnoremap n n:call HLNext(0.2)<cr>
nnoremap N N:call HLNext(0.2)<cr>

vnoremap > >gv
vnoremap < <gv

noremap ; :
noremap : ;

nnoremap Y y$

nnoremap <Space> i_<Esc>r

nnoremap - :Explore<cr>

" Function keys mappings
nnoremap <F1>   :set relativenumber! relativenumber?<cr>
nnoremap <F2>   :set cursorline! cursorline?<cr>
nnoremap <F3>   :set hlsearch! hlsearch?<cr>
nnoremap <F4>   :set spell! spell?<cr>
nnoremap <F5>   :w<cr>:make<cr>
nnoremap <F6>   :w<cr>:!rsync -avz -e ssh ~/SO2/zeos/ alumne@so2:~/zeos/<cr><cr>
nnoremap <F12>  :call system('rm tags')<cr>:call system('ctags --tag-relative -R --exclude=.git')<cr>

" Leader mappings
 noremap                <leader>c :yank +<cr>
 noremap                <leader>j :join<cr>
 noremap                <leader>p :put *<cr>
 noremap                <leader>s :let p=getpos('.')<cr>:%s/\s\+$//<cr>:call setpos('.',p)<cr>
 noremap                <leader>v :put +<cr>
nnoremap                <leader>bc :ls!<cr>:bwipeout
nnoremap                <leader>bs :ls!<cr>:buffer
nnoremap                <leader>fc zM
nnoremap                <leader>fe zMzvzz
nnoremap                <leader>fo zR
nnoremap                <leader>g :!git 
nnoremap                <leader>h :Help 
nnoremap                <leader>L O<Esc>
nnoremap                <leader>l o<Esc>
nnoremap                <leader>m {jlrXdapGp
nnoremap                <leader>o :only<cr>
nnoremap                <leader>t :tag 
nnoremap    <silent>    <leader>. :update<cr>
nnoremap    <silent>    <leader>bk :call BufferKill()<cr>
nnoremap    <silent>    <leader>e :bdelete<cr>
nnoremap    <silent>    <leader>q :q<cr>
nnoremap    <silent>    <leader>Q :qall<cr>

" Functions
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

function! BufferKill()
    let l:count = 0
    for b in range(1, bufnr('$'))
        if bufexists(b) && !bufloaded(b)
            execute 'bwipeout '.b
            let l:count += 1
        endif
    endfor
    echo 'Deleted ' . l:count . ' buffers'
endfunction

function! NeatFoldText()
    let line = ' ' . substitute(getline(v:foldstart), '^\s*"\?\s*\|\s*"\?\s*{{' . '{\d*\s*', '', 'g') . ' '
    let lines_count = v:foldend - v:foldstart + 1
    let lines_count_text = '| ' . printf('%10s', lines_count . ' lines') . ' |'
    let foldchar = matchstr(&fillchars, 'fold:\zs.')
    let foldtextstart = strpart('+' . repeat(foldchar, v:foldlevel*2) . line, 0, (winwidth(0)*2)/3)
    let foldtextend = lines_count_text . repeat(foldchar, 8)
    let foldtextlength = strlen(substitute(foldtextstart . foldtextend, '.', 'x', 'g')) + &foldcolumn
    return foldtextstart . repeat(foldchar, winwidth(0)-foldtextlength) . foldtextend
endfunction

function! HLNext(blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let target_pat = '\c\%#'.@/
    let blinks = 2
    for n in range(1, blinks)
        let red = matchadd('WhiteOnRed', target_pat, 100)
        redraw
        execute 'sleep '.float2nr(a:blinktime/(2*blinks)*1000).'m'
        call matchdelete(red)
        redraw
        execute 'sleep '.float2nr(a:blinktime/(2*blinks)*1000).'m'
    endfor
endfunction
