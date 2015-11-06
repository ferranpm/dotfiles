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
set lazyredraw
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
set wildmode=longest:list
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

" Commands
command! -nargs=1 -complete=help Help if &ft=~'help' | help <args> | else | tab help <args> | endif
command! -nargs=+ Grep silent grep! <args> * | redraw!

command! -nargs=1 -complete=file E call utils#OpenWithHeader(<f-args>)
command! -nargs=? -complete=dir Mkdir call utils#Mkdir(<f-args>)
command! -nargs=+ -complete=command Pipe call utils#Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call utils#Shell(<q-args>)
command! SudoWrite call utils#SudoWriteCmd()

command! -nargs=? UnderscoreToUpperCamelCase <args>s#\m\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2
command! -nargs=? UnderscoreToLowerCamelCase <args>s#\m_\(\l\)#\u\1
command! -nargs=? CamelCaseToUnderscore <args>s#\m\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2

command! -nargs=1 -range Align '<,'>call edit#Align(<f-args>)
command! -nargs=0 JSONFormat call edit#json_format()
command! -nargs=0 Reg call edit#Reg()

command! -nargs=0 Picocom call serial#Picocom()

function! s:ScriptComplete(ArgLead, CmdLine, CursorPos)
    return utils#FolderComplete(a:ArgLead, a:CmdLine, a:CursorPos, "~/.vim/scripts/")
endfunction
command! -nargs=1 -complete=custom,s:ScriptComplete Script source ~/.vim/scripts/<args>

" Mappings
noremap ; :
noremap : ;

nnoremap q; q:
xnoremap q; q:

noremap ` '
noremap ' `

inoremap <C-o> <C-x><C-o><C-p>
inoremap <C-j> <esc>O

nnoremap <silent> <C-@> :call buffer#AlternateSource()<cr>
nnoremap <silent> <C-^> :call buffer#AlternateFile()<cr>

nnoremap ) <Esc>/[)}"'\]>]<CR>
nnoremap ( <Esc>?[({"'\[<]<CR>
vnoremap ) /[)}"'\]>]<CR>
vnoremap ( ?[({"'\[<]<CR>

noremap [[ ?{<CR>w99[{
noremap ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprevious<cr>

nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [t :tprevious<cr>

nnoremap <silent> ]g /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [g ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

vnoremap <M-/> <Esc>/\%V
vnoremap * y/<c-r>=escape('<c-r>0', '*/\[].')<cr><cr>

nnoremap <silent> n n:call movement#HLNext(0.2)<cr>
nnoremap <silent> N N:call movement#HLNext(0.2)<cr>
nnoremap <silent> * *:call movement#HLNext(0.2)<cr>
nnoremap <silent> # #:call movement#HLNext(0.2)<cr>

nnoremap z/ :call edit#AutoHighlightToggle()<cr>

vnoremap > >gv
vnoremap < <gv

nnoremap Y y$

nnoremap - ^

nnoremap <silent> ,. :update<cr>

noremap ! :VimuxRunCommand 
noremap ~ :VimuxTestCommand 

nnoremap <F1>   :Dispatch 
nnoremap <F2>   :setlocal cursorline! cursorline?<cr>
nnoremap <F3>   :setlocal hlsearch! hlsearch?<cr>
nnoremap <F4>   :setlocal spell! spell?<cr>
nnoremap <F9>   :Gstatus<cr>
nnoremap <F12>  :call system('ctags')<cr>

 noremap                <leader>a :Align 
 noremap                <leader>c "+y
 noremap                <leader>p :put *<cr>
 noremap                <leader>v "+p
nnoremap                <leader>vc :VimuxCloseRunner<cr>
nnoremap    <silent>    <leader>zs :%s/\s\+$//<cr>
vnoremap    <silent>    <leader>zs :s/\s\+$//<cr>
nnoremap                <leader>bc :ls!<cr>:bwipeout 
nnoremap                <leader>bw :call buffer#BufferWipeOut()<cr>
nnoremap                <leader>cd :call buffer#SetProjectRoot()<cr>
nnoremap                <leader>d  :only<cr>:Gdiff<cr>
nnoremap                <leader>e :e <C-R>=expand('%:p:h') . '/' <CR>
nnoremap                <leader>fc zM
nnoremap                <leader>fe zMzvzz
nnoremap                <leader>fo zR
nnoremap                <leader>ff :find 
nnoremap                <leader>g :Grep 
nnoremap                <leader>h :Help 
nnoremap                <leader>rs :Shell 
nnoremap                <leader>rp :Pipe 
nnoremap                <leader>L O<Esc>
nnoremap                <leader>l o<Esc>
nnoremap                <leader>mm dapGplrXk/^\[ \]<cr>
nnoremap                <leader>u :call utils#FindUsage(0)<cr>
nnoremap                <leader>U :call utils#FindUsage(1)<cr>
nnoremap                <leader>S :%s/\C\<<C-r>=expand('<cword>')<CR>\>/
nnoremap                <leader>s :s/\C\<<C-r>=expand('<cword>')<CR>\>/
vnoremap                <leader>S y<esc>:%s/\C<C-r>=escape('<C-r>0', '*/\[].~')<cr>/
vnoremap                <leader>s y<esc>:s/\C<C-r>=escape('<C-r>0', '*/\[].~')<cr>/
nnoremap                <leader>t :tag 
nnoremap    <silent>    <leader>. :update<cr>
nnoremap    <silent>    <leader>bk :call buffer#BufferKill()<cr>
nnoremap    <silent>    <leader>ms iSigned-off-by: Ferran Pelayo Monfort <ferran.pel.mon@gmail.com><Esc>
