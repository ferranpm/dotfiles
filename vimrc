" Pathogen
if !has("python")
    let g:pathogen_disabled = ["ultisnips"]
endif
try
    runtime bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry

" Clang-Complete
let g:clang_complete_auto=1
let g:clang_hl_errors=1
let g:clang_snippets=1
let g:clang_close_preview=1

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
let g:ctrlp_working_path_mode='0'
let g:ctrlp_use_caching=0

" Basic configuration
filetype plugin on
filetype indent on
syntax on
let mapleader=','
set nowrap
set autoread
set backspace=2
set encoding=utf-8
set isfname-==
set mouse=n
set nocompatible
set scrolloff=10
set timeoutlen=500
set ttimeoutlen=0
set virtualedit=block
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc,*.tar.*,*.tgz,*.zip,*.rar,__*__

" OS dependent
if has('unix')
    set grepprg=ack\ -i
else
    set makeprg=mingw32-make
endif

" Indicators
set completeopt=menuone
set ruler
set showbreak=>
set showcmd
set showmode
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\'%:~:.:h\')})%)%(\ %a%)

" Windows & splits
set splitright
set splitbelow

" Indentation
set autoindent
set expandtab
set list
set listchars=tab:»\ ,trail:·
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
set foldmethod=syntax
set foldopen=hor,mark,percent,quickfix,search,tag,undo
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
set statusline=%f%m\ %y%h%r%w\ (%l/%L,\ %c)\ %p%%\ %=%{substitute(getcwd(),'^'.$HOME,'~','')}

" Menu
set wildmenu
set wildmode=longest:list,full

" Colors
set t_Co=256
colorscheme xoria256

" Highlights
highlight WhiteOnRed ctermfg=255 ctermbg=196 guifg=#ffffff guibg=#ff0000
highlight IndentWhiteSpaces cterm=undercurl ctermfg=242 gui=underline guifg=#262626
highlight TrilingWhitespace ctermbg=199 guibg=#ff00af
highlight RightMargin ctermbg=93 guibg=#8700ff
call matchadd('RightMargin', '\%81c', 30)
" call matchadd('TrilingWhitespace', '\s\+\%#\@<!$', 70)
" call matchadd('IndentWhiteSpaces', '^ \+', 100)

" GUI
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set columns=9999
    set lines=9999
    set showtabline=2
    if has('unix')
        set guifont=Inconsolata
    elseif has('win32')
        set guifont=Consolas:h9
    endif
endif

" Commands
command! -nargs=+ -complete=command Pipe call Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call Shell(<q-args>)
command! -nargs=1 -complete=help Help if &ft=~"help" | help <args> | else | tab help <args> | endif
command! SudoWrite call SudoWriteCmd()
command! -nargs=? UnderscoreToUpperCamelCase <args>s#\m\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2
command! -nargs=? UnderscoreToLowerCamelCase <args>s#\m_\(\l\)#\u\1
command! -nargs=? CamelCaseToUnderscore <args>s#\m\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2
command! -nargs=+ Grep silent grep! <args> * | copen | redraw!
command! -nargs=* Make silent make! <args> | copen | redraw!
command! -nargs=1 -range Align '<,'>call Align(<f-args>)

" Mappings
nmap J 5j
nmap K 5k

xmap J 5j
xmap K 5k

vmap Q gq
nmap Q gqap

inoremap <C-o> <C-x><C-o><C-p>
inoremap <C-j> <esc>O

nnoremap ) <Esc>/[)}"'\]>]<CR>
nnoremap ( <Esc>?[({"'\[<]<CR>
vnoremap ) /[)}"'\]>]<CR>
vnoremap ( ?[({"'\[<]<CR>


nnoremap <C-l> <C-w><C-l>
nnoremap <C-h> <C-w><C-h>
nnoremap <C-j> <C-w><C-j>
nnoremap <C-k> <C-w><C-k>

nnoremap ]q :cnext<cr>
nnoremap [q :cprevious<cr>

nnoremap ]t :tnext<cr>
nnoremap [t :tprevious<cr>

nnoremap <silent> <up>   :move .-2<cr>
nnoremap <silent> <down> :move .+1<cr>
vnoremap <silent> <up>   :move .-2<cr>gv
vnoremap <silent> <down> :move '>+<cr>gv

vnoremap <M-/> <Esc>/\%V

nnoremap <silent> <right> gt
nnoremap <silent> <left>  gT
nnoremap <silent> <C-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

nnoremap <silent> n n:call HLNext(0.2)<cr>
nnoremap <silent> N N:call HLNext(0.2)<cr>
nnoremap <silent> * *:call HLNext(0.2)<cr>
nnoremap <silent> # #:call HLNext(0.2)<cr>

vnoremap > >gv
vnoremap < <gv

noremap ; :
noremap : ;

nnoremap Y y$

nnoremap <Space> i_<Esc>r

nnoremap - :Explore<cr>

" Function keys mappings
if has('unix')
    nnoremap <F1>   :!clear; 
else
    nnoremap <F1>   :!
endif
nnoremap <F2>   :set cursorline! cursorline?<cr>
nnoremap <F3>   :set hlsearch! hlsearch?<cr>
nnoremap <F4>   :set spell! spell?<cr>
nnoremap <F5>   :update<cr>:Make<cr>
nnoremap <F9>   :Gstatus<cr>
nnoremap <F12>  :call system('ctags')<cr>

" Leader mappings
 noremap                <leader>a :Align 
 noremap                <leader>c "+y
 noremap                <leader>j :join<cr>
 noremap                <leader>p :put *<cr>
 noremap                <leader>v "+p
 noremap    <silent>    <leader>zs :let p=getpos('.')<cr>:%s/\s\+$//<cr>:call setpos('.',p)<cr>
nnoremap                <leader>bc :ls!<cr>:bwipeout 
nnoremap                <leader>bs :CtrlPBuffer<cr>
nnoremap                <leader>bw :e #<cr>:bwipeout #<cr>
nnoremap                <leader>d :set diff! scrollbind!<cr>:set diff? scrollbind?<cr>
nnoremap                <leader>fc zM
nnoremap                <leader>fe zMzvzz
nnoremap                <leader>fo zR
nnoremap                <leader>g :Grep 
nnoremap                <leader>h :Help 
nnoremap                <leader>L O<Esc>
nnoremap                <leader>l o<Esc>
nnoremap                <leader>m; :s/;$/ {\r}\rkVk=o
nnoremap                <leader>S :%s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap                <leader>s :s/\<<C-r>=expand('<cword>')<CR>\>/
vnoremap                <leader>S y<esc>:%s/<C-r>0/
vnoremap                <leader>s y<esc>:s/<C-r>0/
nnoremap                <leader>t :CtrlPTag<cr>
vnoremap                <leader>m; :s/;$/ {\r}\rgv=
nnoremap    <silent>    <leader>. :update<cr>
nnoremap    <silent>    <leader>bk :call BufferKill()<cr>
nnoremap    <silent>    <leader>e :close<cr>
nnoremap    <silent>    <leader>ms iSigned-off-by: Ferran Pelayo Monfort <ferran.pel.mon@gmail.com><Esc>
nnoremap    <silent>    <leader>q :quit<cr>
nnoremap    <silent>    <leader>Q :quitall<cr>

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

function! SudoWriteCmd() abort
  execute (has('gui_running') ? '' : 'silent') 'write !env SUDO_EDITOR=tee sudo -e % >/dev/null'
  let &modified = v:shell_error
endfunction

function! MaxColumn(string, startline, endline, column)
    let l:cursor_save = getpos('.')
    let l:max_column = 0
    for line in range(a:endline - a:startline + 1)
        call cursor(a:startline + line, a:column)
        call search(a:string, 'c', line('.'))
        let l:current_column = col('.')
        if l:current_column > l:max_column
            let l:max_column = l:current_column
        endif
    endfor
    call setpos('.', l:cursor_save)
    return l:max_column
endfunction

function! Align(string) range
    let col = min([ virtcol("'<"), virtcol("'>") ])
    let l:cursor_save = getpos('.')
    let l:max_column = MaxColumn(a:string, a:firstline, a:lastline, col)
    for line in range(a:lastline - a:firstline + 1)
        call cursor(a:firstline + line, col)
        if search(a:string, 'c', line('.')) != 0
            let delta_col = (l:max_column - col('.'))
            if delta_col > 0
                exe "normal ".delta_col."i "
            endif
        endif
    endfor
    call setpos('.', l:cursor_save)
endfunction
