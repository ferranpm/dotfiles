" vim: foldmethod=marker foldlevel=0
" Vundle {{{
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
" }}}

if filereadable(expand('~/.local.vim'))
    source ~/.local.vim
endif

" Mail {{{
let g:mail_netrc='~/.netrc'
let g:mail_imap_ssl=1
if exists('g:mail_account') && g:mail_account == 'fib'
    " fib
    let g:mail_smtp_server='mail.fib.upc.es'
    let g:mail_smtp_port=1025
    let g:mail_imap_server='correu.fib.upc.es'
    let g:mail_imap_port=993
else
    " gmail
    let g:mail_smtp_server='smtp.gmail.com'
    let g:mail_smtp_port=587
    let g:mail_imap_server='imap.gmail.com'
    let g:mail_imap_port=993
endif
" }}}

" Clang-Complete {{{
let g:clang_complete_auto=1
let g:clang_hl_errors=1
let g:clang_snippets=0
let g:clang_close_preview=1
" }}}

" Netrw {{{
let g:netrw_banner=0
let g:netrw_liststyle=1
let g:netrw_keepdir=1
" }}}

" UltiSnips {{{
let g:UltiSnipsExpandTrigger='<tab>'
let g:UltiSnipsJumpForwardTrigger='<tab>'
let g:UltiSnipsJumpBackwardTrigger='<s-tab>'
" }}}

" CtrlP {{{
let g:ctrlp_cmd = 'CtrlPBuffer'
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
let mapleader=' '
set exrc
set nowrap
set autoread
set backspace=2
set encoding=utf-8
set hidden confirm
set modeline
set mouse=n
set nocompatible
set scrolloff=4
set timeoutlen=500
set ttimeoutlen=0
set virtualedit=block
set wildignore+=.git/*,.gitignore,*.class,*.o,*.pyc,*.tar.*,*.tgz,*.zip,*.rar,__*__
set wildignorecase
" }}}

" Programs {{{
if has('unix')
    set grepprg=ack\ -i
    set makeprg=make\ -j8
else
    set makeprg=mingw32-make\ -j8
    set grepprg=grep\ -ri
endif
" }}}

" Indicators {{{
set completeopt=menuone
set number
set relativenumber
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
set switchbuf=useopen
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
set foldtext=FoldText()
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
" }}}

" GUI {{{
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
" }}}

" Commands {{{
command! -nargs=+ -complete=command Pipe call Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call Shell(<q-args>)
command! -nargs=1 -complete=help Help if &ft=~'help' | help <args> | else | tab help <args> | endif
command! SudoWrite call SudoWriteCmd()
command! -nargs=? UnderscoreToUpperCamelCase <args>s#\m\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2
command! -nargs=? UnderscoreToLowerCamelCase <args>s#\m_\(\l\)#\u\1
command! -nargs=? CamelCaseToUnderscore <args>s#\m\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2
command! -nargs=+ Grep silent grep! <args> * | redraw!
command! -nargs=1 -range Align '<,'>call Align(<f-args>)
command! -nargs=0 Reg call Reg()
command! -nargs=1 -complete=file E call OpenWithHeader(<f-args>)
command! -nargs=0 JSONFormatter call JSONFormatter()
command! -nargs=1 -complete=custom,ScriptComplete Script source ~/.vim/scripts/<args>
" }}}

" Autocommands {{{
augroup autocommands
    autocmd! VimResized * :wincmd =
    autocmd! QuickFixCmdPost * :cwindow
augroup END
" }}}

" Mappings {{{
nnoremap q; q:
xnoremap q; q:

inoremap <C-o> <C-x><C-o><C-p>
inoremap <C-j> <esc>O

nnoremap <silent> <C-@> :call AlternateSource()<cr>
nnoremap <silent> <C-^> :call AlternateFile()<cr>

nnoremap ) <Esc>/[)}"'\]>]<CR>
nnoremap ( <Esc>?[({"'\[<]<CR>
vnoremap ) /[)}"'\]>]<CR>
vnoremap ( ?[({"'\[<]<CR>

noremap [[ ?{<CR>w99[{
noremap ][ /}<CR>b99]}
map ]] j0[[%/{<CR>
map [] k$][%?}<CR>

vnoremap <cr> y :if &bt == 'terminal' \| startinsert \| endif<cr>
if has('nvim')
    tnoremap <C-g> <C-\><C-n>
    tnoremap <C-g><C-p> <C-\><C-n>pi
    tnoremap <silent> <C-^> <C-\><C-n>:call AlternateFile()<cr>
    tnoremap <silent> <C-\>n <C-\><C-n>? \<in\> ?e<cr>wyiW:cd <c-r>0<cr>i
    tnoremap <silent> <C-\>t cd <C-\><C-n>:let @@=getcwd() \| .put 0<cr>i<cr>
    tnoremap <C-w>h <C-\><C-n><C-w>h
    tnoremap <C-w>j <C-\><C-n><C-w>j
    tnoremap <C-w>k <C-\><C-n><C-w>k
    tnoremap <C-w>l <C-\><C-n><C-w>l
endif

nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprevious<cr>

nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [t :tprevious<cr>

nnoremap <silent> ]g /\v^(\<\|\=\|\>){7}([^=].+)?$<CR>
nnoremap <silent> [g ?\v^(\<\|\=\|\>){7}([^=].+)\?$<CR>

vnoremap <M-/> <Esc>/\%V
vnoremap * y/<c-r>=escape('<c-r>0', '*/\[].')<cr><cr>

nnoremap <silent> n n:call HLNext(0.2)<cr>
nnoremap <silent> N N:call HLNext(0.2)<cr>
nnoremap <silent> * *:call HLNext(0.2)<cr>
nnoremap <silent> # #:call HLNext(0.2)<cr>

nnoremap z/ :call AutoHighlightToggle()<cr>

vnoremap > >gv
vnoremap < <gv

noremap ; :
noremap : ;

nnoremap Y y$

nnoremap - ^

nnoremap <silent> ,. :update<cr>
noremap ` '
noremap ' `
" }}}

" Function keys mappings {{{
nnoremap <F1>   :Dispatch 
nnoremap <F2>   :set cursorline! cursorline?<cr>
nnoremap <F3>   :set hlsearch! hlsearch?<cr>
nnoremap <F4>   :set spell! spell?<cr>
nnoremap <F5>   :call Make()<cr>
nnoremap <F9>   :Gstatus<cr>
nnoremap <F12>  :call system('ctags')<cr>
" }}}

" Leader mappings {{{
 noremap                <leader>a :Align 
 noremap                <leader>c "+y
 noremap                <leader>p :put *<cr>
 noremap                <leader>v "+p
nnoremap    <silent>    <leader>zs :%s/\s\+$//<cr>
vnoremap    <silent>    <leader>zs :s/\s\+$//<cr>
nnoremap                <leader>bc :ls!<cr>:bwipeout 
nnoremap                <leader>bs :CtrlPBuffer<cr>
nnoremap                <leader>bw :call BufferWipeOut()<cr>
nnoremap                <leader>cd :call SetProjectRoot()<cr>
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
nnoremap                <leader>u :call FindUsage(0)<cr>
nnoremap                <leader>U :call FindUsage(1)<cr>
nnoremap                <leader>S :%s/\C\<<C-r>=expand('<cword>')<CR>\>/
nnoremap                <leader>s :s/\C\<<C-r>=expand('<cword>')<CR>\>/
vnoremap                <leader>S y<esc>:%s/\C<C-r>=escape('<C-r>0', '*/\[].')<cr>/
vnoremap                <leader>s y<esc>:s/\C<C-r>=escape('<C-r>0', '*/\[].')<cr>/
nnoremap                <leader>t :CtrlPTag<cr>
nnoremap    <silent>    <leader>. :update<cr>
nnoremap    <silent>    <leader>bk :call BufferKill()<cr>
nnoremap    <silent>    <leader>ms iSigned-off-by: Ferran Pelayo Monfort <ferran.pel.mon@gmail.com><Esc>
" }}}

" Functions {{{
" GoToBuffer({name}[, {methodnew}[, {switchbuf}]])
function! GoToBuffer(name, ...) " {{{
    let methodnew = 'tabnew'
    let switchbuf = 'usetab'
    let oldswitchbuf = &switchbuf
    if a:0 > 0 | let methodnew = a:1 | endif
    if a:0 > 1 | let switchbuf = a:2 | endif
    execute 'set switchbuf='.switchbuf
    if bufexists(a:name)
        execute 'sbuffer '.a:name
    else
        execute methodnew
    endif
    execute 'file '.a:name
    execute 'set switchbuf='.oldswitchbuf
endfunction " }}}

function! Pipe(cmd) " {{{
    call GoToBuffer('Pipe', 'vnew')
    normal ggdG
    redir @+>
    silent execute a:cmd
    redir END
    silent 0put +
    normal! ggdd
    set nomodified
endfunction " }}}

function! Shell(cmd) " {{{
    call GoToBuffer('Shell', 'vnew')
    normal! ggdG
    execute 'read !'.a:cmd
    normal! ggdd
    set nomodified
endfunction " }}}

function! BufferKill() " {{{
    let l:count = 0
    for b in range(1, bufnr('$'))
        if bufexists(b) && !buflisted(b)
            execute 'bwipeout '.b
            let l:count += 1
        endif
    endfor
    echo 'Deleted ' . l:count . ' buffers'
endfunction " }}}

function! FoldText() " {{{
    let line = getline(v:foldstart)
    let nucolwidth = &foldcolumn + &number * &numberwidth
    let windowwidth = winwidth(0) - nucolwidth - 3
    " expand tabs into spaces
    let onetab = strpart('          ', 0, &tabstop)
    let line = substitute(line, '\t', onetab, 'g')
    if &foldmethod == 'marker'
        let line = substitute(line, ' {{{', onetab, 'g') " }}}
    endif
    let line = strpart(line, 0, windowwidth - 2)
    let fillcharcount = windowwidth
    return line . repeat(' ', fillcharcount)
endfunction " }}}

function! HLNext(blinktime) " {{{
    let [bufnum, lnum, col, off] = getpos('.')
    let target_pat = '\c\%#'.@/
    let blinks = 1
    for n in range(1, blinks)
        let red = matchadd('WhiteOnRed', target_pat, 100)
        redraw
        execute 'sleep '.float2nr(a:blinktime/(2*blinks)*500).'m'
        call matchdelete(red)
        redraw
        execute 'sleep '.float2nr(a:blinktime/(2*blinks)*500).'m'
    endfor
endfunction " }}}

function! SudoWriteCmd() abort " {{{
    execute (has('gui_running') ? '' : 'silent') 'write !env SUDO_EDITOR=tee sudo -e % >/dev/null'
    let &modified = v:shell_error
endfunction " }}}

function! MaxColumn(string, startline, endline, column) " {{{
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
endfunction " }}}

function! Align(string) range " {{{
    let col = min([ virtcol("'<"), virtcol("'>") ])
    let l:cursor_save = getpos('.')
    let l:max_column = MaxColumn(a:string, a:firstline, a:lastline, col)
    for line in range(a:lastline - a:firstline + 1)
        call cursor(a:firstline + line, col)
        if search(a:string, 'c', line('.')) != 0
            let delta_col = (l:max_column - col('.'))
            if delta_col > 0
                exe 'normal! '.delta_col.'i '
            endif
        endif
    endfor
    call setpos('.', l:cursor_save)
endfunction " }}}

function! Reg() " {{{
    reg
    echo 'Register: '
    let char = nr2char(getchar())
    if char != "\<Esc>"
        execute 'normal! "'.char.'p'
    endif
    redraw
endfunction " }}}

function! AutoHighlightToggle() " {{{
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
endfunction " }}}

let g:ft_to_header = {
            \ 'c': ['h'],
            \ 'cpp': ['h', 'hpp']
            \ }
let g:header_to_source = {
            \ 'h': ['c', 'cpp'],
            \ 'hpp': ['cpp']
            \ }
function! OpenWithHeader(file) " {{{
    wincmd o
    execute 'e '.a:file
    let extension = expand('%:e')
    let filebase = expand('%:r')
    if has_key(g:header_to_source, extension)
        let extensions = g:header_to_source[extension]
    elseif has_key(g:ft_to_header, &ft)
        let extensions = g:ft_to_header[&ft]
    else
        return
    endif
    for ext in extensions
        let file = filebase.'.'.ext
        if filereadable(file)
            execute 'vs '.file
            wincmd h
            return
        endif
    endfor
    let selection = 0
    if len(extensions) > 1
        let selection = inputlist(map(copy(extensions), 'v:key . ". " . v:val'))
    endif
    execute 'vs '.filebase.'.'.extensions[selection]
endfunction " }}}

function! AlternateSource() " {{{
    let filebase = expand('%:r')
    let extension = expand('%:e')
    let file = ''
    let extensions = []
    if has_key(g:header_to_source, extension)
        let extensions = g:header_to_source[extension]
    elseif has_key(g:ft_to_header, &ft)
        let extensions = g:ft_to_header[&ft]
    endif
    for ext in extensions
        let file = filebase.'.'.ext
        if filereadable(file)
            execute 'e '.file
            return
        endif
    endfor
endfunction " }}}

function! AlternateFile() " {{{
    try
        buffer #
    catch
        for b in reverse(range(1, bufnr('$')))
            if bufexists(b) && buflisted(b) && b != bufnr('%')
                execute 'buffer '.b
                return
            endif
        endfor
    endtry
endfunction " }}}

function! BufferWipeOut() " {{{
    call AlternateFile()
    try
        bwipeout #
    catch
        bwipeout
    endtry
endfunction " }}}

function! JSONFormatter() " {{{
    set ft=json
    silent %s/[{[,]/&\r/e
    silent %s/[}\]]/\r&/e
    silent normal! gg=G
endfunction " }}}

" FindUsage([{recursive} [, {pattern} [, {path}]]])
function! FindUsage(...) " {{{
    let recursive = 0
    let pattern = expand('<cword>')
    let path = getcwd()
    if a:0 > 0 | let recursive = a:1 | endif
    if a:0 > 1 | let pattern   = a:2 | endif
    if a:0 > 2 | let path      = a:3 | endif
    if !exists('a:3') && !recursive
        let path = expand('%:h')
    endif
    let path = escape(path, ' ')
    execute 'vimgrep! /\C\<'.pattern.'\>/j '.path.'/'.(recursive ? '**' : '*')
endfunction " }}}

function! SetProjectRoot() " {{{
    lcd %:p:h
    let git_dir = system('git rev-parse --show-toplevel')
    let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
    if empty(is_not_git_dir)
        lcd `=git_dir`
    endif
endfunction " }}}

function! Make() " {{{
    update
    let make = exists(':Make') == 2 ? 'Make ' : 'make '
    if filereadable('Makefile') || filereadable('AndroidManifest.xml')
        execute make
    elseif expand('%:e') == 'ino'
        execute make.'%'
    else
        execute make.expand('%:r')
    endif
endfunction " }}}

function! ScriptComplete(ArgLead, CmdLine, CursorPos)
    return join(map(glob("~/.vim/scripts/*", 1, 1), 'substitute(v:val, expand("~/.vim/scripts/"), "", "")'), "\n")
endfunction
" }}}
