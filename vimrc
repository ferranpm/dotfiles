" vim: foldmethod=marker foldlevel=0
" Pathogen {{{
if !has("python")
    let g:pathogen_disabled = ["ultisnips"]
endif
try
    runtime bundle/pathogen/autoload/pathogen.vim
    call pathogen#infect()
catch
endtry
" }}}

" Incsearch {{{
map /  <Plug>(incsearch-forward)
map ?  <Plug>(incsearch-backward)
noremap g/ /
" }}}

" Clang-Complete {{{
let g:clang_complete_auto=1
let g:clang_hl_errors=1
let g:clang_snippets=1
let g:clang_close_preview=1
" }}}

" Netrw {{{
let g:netrw_banner=0
let g:netrw_liststyle=1
let g:netrw_keepdir=1
" }}}

" UltiSnips {{{
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
" }}}

" CtrlP {{{
let g:ctrlp_by_filename=1
let g:ctrlp_max_files=500
let g:ctrlp_max_height=100
let g:ctrlp_show_hidden=0
let g:ctrlp_use_caching=0
let g:ctrlp_working_path_mode='0'
" }}}

" Basic configuration {{{
filetype plugin on
filetype indent on
syntax on
let mapleader=','
set exrc
set nowrap
set autoread
set backspace=2
set encoding=utf-8
set hidden confirm
set modeline
set mouse=n
set nocompatible
set scrolloff=10
set timeoutlen=500
set ttimeoutlen=0
set virtualedit=block
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc,*.tar.*,*.tgz,*.zip,*.rar,__*__
" }}}

" Programs {{{
if has('unix')
    set grepprg=ack\ -i
else
    set makeprg=mingw32-make
endif
" }}}

" Indicators {{{
set completeopt=menuone
set ruler
set showbreak=>
set showcmd
set showmode
set title
set titlestring=%t%(\ %M%)%(\ (%{expand(\'%:~:.:h\')})%)%(\ %a%)
" }}}

" Windows & splits {{{
set splitright
set splitbelow
" }}}

" Indentation {{{
set autoindent
set expandtab
set list
set listchars=tab:»\ ,trail:·
set shiftwidth=4
set smartindent
set smarttab
" }}}

" Search & Replace {{{
set gdefault
set ignorecase
set incsearch
set smartcase
" }}}

" Folds {{{
set foldmethod=syntax
set foldopen=hor,mark,percent,quickfix,search,tag,undo
set foldnestmax=1
set foldcolumn=1
set foldlevel=1
set foldtext=NeatFoldText()
" }}}

" Backups {{{
set nobackup
set noswapfile
set nowritebackup
" }}}

" Status Line {{{
set laststatus=2
set statusline=%f%m\ %y%h%r%w\ (%l/%L,\ %c)\ %p%%\ %=%{substitute(getcwd(),'^'.$HOME,'~','')}
" }}}

" Menu {{{
set wildmenu
set wildmode=longest:list,full
" }}}

" Colors {{{
set t_Co=256
set background=dark
colorscheme xoria256
" }}}

" Highlights {{{
highlight WhiteOnRed ctermfg=255 ctermbg=196 guifg=#ffffff guibg=#ff0000
highlight IndentWhiteSpaces cterm=undercurl ctermfg=242 gui=underline guifg=#262626
highlight TrilingWhitespace ctermbg=199 guibg=#ff00af
highlight RightMargin ctermbg=93 guibg=#8700ff
call matchadd('RightMargin', '\%81c', 30)
" call matchadd('TrilingWhitespace', '\s\+\%#\@<!$', 70)
" call matchadd('IndentWhiteSpaces', '^ \+', 100)
" }}}

" GUI {{{
if has('gui_running')
    set guioptions-=m
    set guioptions-=T
    set columns=9999
    set lines=9999
    set showtabline=2
    if has('unix')
        set guifont=Inconsolata\ 13
    elseif has('win32')
        set guifont=Consolas:h11
    endif
endif
" }}}

" Commands {{{
command! -nargs=+ -complete=command Pipe call Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call Shell(<f-args>)
command! -nargs=1 -complete=help Help if &ft=~"help" | help <args> | else | tab help <args> | endif
command! SudoWrite call SudoWriteCmd()
command! -nargs=? UnderscoreToUpperCamelCase <args>s#\m\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2
command! -nargs=? UnderscoreToLowerCamelCase <args>s#\m_\(\l\)#\u\1
command! -nargs=? CamelCaseToUnderscore <args>s#\m\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2
command! -nargs=+ Grep silent grep! <args> * | copen | redraw!
command! -nargs=1 -range Align '<,'>call Align(<f-args>)
command! -nargs=0 Reg call Reg()
command! -nargs=1 -complete=file E call OpenWithHeader(<f-args>)
command! -nargs=0 JSONFormatter call JSONFormatter()
" }}}

" Autocommands {{{
autocmd VimResized * :wincmd =
" }}}

" Mappings {{{
nmap J 5j
nmap K 5k

xmap J 5j
xmap K 5k

inoremap <C-o> <C-x><C-o><C-p>
inoremap <C-j> <esc>O

inoremap <C-^> <Esc><C-^>

nnoremap ) <Esc>/[)}"'\]>]<CR>
nnoremap ( <Esc>?[({"'\[<]<CR>
vnoremap ) /[)}"'\]>]<CR>
vnoremap ( ?[({"'\[<]<CR>

nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprevious<cr>

nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [t :tprevious<cr>

" Jump to next/previous merge conflict marker
nnoremap <silent> ]g /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [g ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

nnoremap <silent> <up>   :move .-2<cr>
nnoremap <silent> <down> :move .+1<cr>
vnoremap <silent> <up>   :move .-2<cr>gv
vnoremap <silent> <down> :move '>+<cr>gv

vnoremap <M-/> <Esc>/\%V
vnoremap * y/0<cr>

nnoremap <silent> <right> gt
nnoremap <silent> <left>  gT
nnoremap <silent> <C-Left> :execute 'silent! tabmove ' . (tabpagenr()-2)<CR>
nnoremap <silent> <C-Right> :execute 'silent! tabmove ' . tabpagenr()<CR>

nnoremap <silent> n n:call HLNext(0.2)<cr>
nnoremap <silent> N N:call HLNext(0.2)<cr>
nnoremap <silent> * *:call HLNext(0.2)<cr>
nnoremap <silent> # #:call HLNext(0.2)<cr>

nnoremap M K
nnoremap z/ :call AutoHighlightToggle()<cr>

vnoremap > >gv
vnoremap < <gv

noremap ; :
noremap : ;

nnoremap Y y$

nnoremap <Space> i_<Esc>r
vnoremap <Space> I_<Esc>gvr

nnoremap - :Explore<cr>
" }}}

" Function keys mappings {{{
if has('unix')
    nnoremap [11~ :!clear; 
    nnoremap [12~ :set cursorline! cursorline?<cr>
    nnoremap [13~ :set hlsearch! hlsearch?<cr>
    nnoremap [14~ :set spell! spell?<cr>
    nnoremap [15~ :update<cr>:Make<cr>
    nnoremap [20~ :Gstatus<cr>
    nnoremap [24~ :call system('ctags')<cr>
else
    nnoremap <F1>   :!
    nnoremap <F2>   :set cursorline! cursorline?<cr>
    nnoremap <F3>   :set hlsearch! hlsearch?<cr>
    nnoremap <F4>   :set spell! spell?<cr>
    nnoremap <F5>   :update<cr>:Make<cr>
    nnoremap <F9>   :Gstatus<cr>
    nnoremap <F12>  :call system('ctags')<cr>
endif
" }}}

" Leader mappings {{{
 noremap                <leader>a :Align 
 noremap                <leader>c "+y
 noremap                <leader>j :join<cr>
 noremap                <leader>p :put *<cr>
 noremap                <leader>v "+p
nnoremap    <silent>    <leader>zs :%s/\s\+$//<cr>
vnoremap    <silent>    <leader>zs :s/\s\+$//<cr>
nnoremap                <leader>bc :ls!<cr>:bwipeout 
nnoremap                <leader>bs :CtrlPBuffer<cr>
nnoremap                <leader>bw :e #<cr>:bwipeout #<cr>
nnoremap                <leader>cd :cd <C-R>=expand("%:p:h") . "/" <CR>
nnoremap                <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap                <leader>fc zM
nnoremap                <leader>fe zMzvzz
nnoremap                <leader>fo zR
nnoremap                <leader>ff :find 
nnoremap                <leader>g :Grep 
nnoremap                <leader>h :Help 
nnoremap                <leader>L O<Esc>
nnoremap                <leader>l o<Esc>
nnoremap                <leader>m; :s/;$/ {\r}\rkVk=o
nnoremap                <leader>mm dapGplrXk/^\[ \]<cr>
nnoremap                <leader>S :%s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap                <leader>s :s/\<<C-r>=expand('<cword>')<CR>\>/
vnoremap                <leader>S y<esc>:%s/<C-r>0/
vnoremap                <leader>s y<esc>:s/<C-r>0/
nnoremap                <leader>t :CtrlPTag<cr>
vnoremap                <leader>m; :s/;$/ {\r}\rgv=
nnoremap    <silent>    <leader>. :update<cr>
nnoremap    <silent>    <leader>bk :call BufferKill()<cr>
nnoremap    <silent>    <leader>ms iSigned-off-by: Ferran Pelayo Monfort <ferran.pel.mon@gmail.com><Esc>
" }}}

" Functions {{{
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
    let line = getline(v:foldstart)

    let nucolwidth = &fdc + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3

    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')

    let line = strpart(line, 0, windowwidth - 2)
    let fillcharcount = windowwidth

    return line . repeat(" ", fillcharcount)
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

function! Reg()
    reg
    echo "Register: "
    let char = nr2char(getchar())
    if char != "\<Esc>"
        execute "normal! \"".char."p"
    endif
    redraw
endfunction

function! AutoHighlightToggle()
    if exists('#auto_highlight')
        match none IncSearch
        autocmd! auto_highlight
        augroup! auto_highlight
        augroup END
        setl updatetime=5000
        echo 'Highlight current word: OFF'
    else
        augroup auto_highlight
            autocmd! CursorHold * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
        augroup END
        setl updatetime=500
        echo 'Highlight current word: ON'
    endif
endfunction

let g:headers = { 'c': '.h', 'cpp': '.h', 'ruby': '_spec.rb' }
function! OpenWithHeader(file)
    normal o
    exec "e ".a:file
    if has_key(g:headers, &ft)
        let header = expand("%:r").g:headers[&ft]
        if filereadable(header)
            exec "vs ".header
            normal h
        endif
    endif
endfunction

function! JSONFormatter()
    set ft=json
    silent %s/[{\[]/&\r/e
    silent %s/[}\]]/\r&/e
    silent %s/,/&\r/e
    silent normal gg=G
endfunction
" }}}
