" vim: foldmethod=marker
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

if filereadable(expand("~/.local.vim"))
    source ~/.local.vim
endif

" Mail {{{
let g:mail_netrc="~/.netrc"
let g:mail_imap_ssl=1
if exists("g:mail_account") && g:mail_account == "fib"
    " fib
    let g:mail_smtp_server="mail.fib.upc.es"
    let g:mail_smtp_port=1025
    let g:mail_imap_server="correu.fib.upc.es"
    let g:mail_imap_port=993
else
    " gmail
    let g:mail_smtp_server="smtp.gmail.com"
    let g:mail_smtp_port=587
    let g:mail_imap_server="imap.gmail.com"
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
    set makeprg=mingw32-make\ -j8
    set grepprg=grep\ -ri
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
        set guifont=Consolas:h10
    endif
endif
" }}}

" Commands {{{
command! -nargs=+ -complete=command Pipe call Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call Shell(<q-args>)
command! -nargs=1 -complete=help Help if &ft=~"help" | help <args> | else | tab help <args> | endif
command! SudoWrite call SudoWriteCmd()
command! -nargs=? UnderscoreToUpperCamelCase <args>s#\m\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2
command! -nargs=? UnderscoreToLowerCamelCase <args>s#\m_\(\l\)#\u\1
command! -nargs=? CamelCaseToUnderscore <args>s#\m\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2
command! -nargs=+ Grep silent grep! <args> * | copen | redraw!
command! -nargs=1 -range Align '<,'>call Align(<f-args>) | normal! gv
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

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

nnoremap <silent> ]q :cnext<cr>
nnoremap <silent> [q :cprevious<cr>

nnoremap <silent> ]t :tnext<cr>
nnoremap <silent> [t :tprevious<cr>

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

nnoremap - ^

nnoremap <silent> ,. :update<cr>
noremap ` '
noremap ' `
" }}}

" Function keys mappings {{{
if has('unix') && !has('gui_running')
    nnoremap OP :Dispatch 
    nnoremap OQ :set cursorline! cursorline?<cr>
    nnoremap OR :set hlsearch! hlsearch?<cr>
    nnoremap OS :set spell! spell?<cr>
    nnoremap [15~ :wa<cr>:Make<cr>
    nnoremap [20~ :Gstatus<cr>
    nnoremap [21~ :call system('ctags')<cr>
else
    nnoremap <F1>   :Dispatch 
    nnoremap <F2>   :set cursorline! cursorline?<cr>
    nnoremap <F3>   :set hlsearch! hlsearch?<cr>
    nnoremap <F4>   :set spell! spell?<cr>
    nnoremap <F5>   :wa<cr>:Make<cr>
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
nnoremap                <leader>bw :call BWipeOut()<cr>
nnoremap                <leader>cd :call SetProjectRoot()<cr>
nnoremap                <leader>d  :only<cr>:Gdiff<cr>
nnoremap                <leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
nnoremap                <leader>fc zM
nnoremap                <leader>fe zMzvzz
nnoremap                <leader>fo zR
nnoremap                <leader>ff :find 
nnoremap                <leader>g :Grep 
nnoremap                <leader>h :Help 
nnoremap                <leader>L O<Esc>
nnoremap                <leader>l o<Esc>
nnoremap                <leader>mm dapGplrXk/^\[ \]<cr>
nnoremap                <leader>u :call FindUsage(0)<cr>
nnoremap                <leader>U :call FindUsage(1)<cr>
nnoremap                <leader>S :%s/\<<C-r>=expand('<cword>')<CR>\>/
nnoremap                <leader>s :s/\<<C-r>=expand('<cword>')<CR>\>/
vnoremap                <leader>S y<esc>:%s/<C-r>=escape('<C-r>0', '/\[]')<cr>/
vnoremap                <leader>s y<esc>:s/<C-r>=escape('<C-r>0', '/\[]')<cr>/
nnoremap                <leader>t :CtrlPTag<cr>
nnoremap    <silent>    <leader>. :update<cr>
nnoremap    <silent>    <leader>bk :call BufferKill()<cr>
nnoremap    <silent>    <leader>ms iSigned-off-by: Ferran Pelayo Monfort <ferran.pel.mon@gmail.com><Esc>
" }}}

" Functions {{{
function! GoToBuffer(name, method)
    if bufexists(a:name)
        execute 'sbuffer '.a:name
    else
        execute a:method
        execute 'file '.a:name
    endif
endfunction

function! Pipe(cmd)
    call GoToBuffer('Pipe', 'vnew')
    normal ggdG
    redir @+>
    silent execute a:cmd
    redir END
    silent 0put +
    normal! ggdd
    set nomodified
endfunction

function! Shell(cmd)
    call GoToBuffer('Shell', 'vnew')
    normal! ggdG
    execute 'read !'.a:cmd
    normal! ggdd
    set nomodified
endfunction

function! BufferKill()
    let l:count = 0
    for b in range(1, bufnr('$'))
        if bufexists(b) && !buflisted(b)
            execute 'bwipeout '.b
            let l:count += 1
        endif
    endfor
    echo 'Deleted ' . l:count . ' buffers'
endfunction

function! FoldText()
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
                exe "normal! ".delta_col."i "
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
    wincmd o
    exec "e ".a:file
    if has_key(g:headers, &ft)
        let header = expand("%:r").g:headers[&ft]
        if filereadable(header)
            exec "vs ".header
            wincmd h
        endif
    endif
endfunction

function! BWipeOut()
    if bufexists(bufname('#'))
        buffer #
    else
        exec "buffer ".last_buffer_nr()
    endif
    if (bufexists(bufname('#')))
        bwipeout #
    else
        bwipeout
    endif
endfunction

function! JSONFormatter()
    set ft=json
    silent %s/[{[,]/&\r/e
    silent %s/[}\]]/\r&/e
    silent normal! gg=G
endfunction

" FindUsage([{recursive} [, {pattern} [, {path}]]])
function! FindUsage(...)
    let recursive = '*'
    let pattern = expand('<cword>')
    let path = escape(expand("%:p:h"), ' ')
    if a:0 > 0 && a:1 != 0 | let recursive = '**' | endif
    if a:0 > 1             | let pattern   = a:2  | endif
    if a:0 > 2             | let path      = a:3  | endif
    silent! execute 'vimgrep! /\C\<'.pattern.'\>/j '.path.'/'.recursive
    copen
endfunction
" }}}

function! SetProjectRoot()
  lcd %:p:h
  let git_dir = system("git rev-parse --show-toplevel")
  let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
  if empty(is_not_git_dir)
    lcd `=git_dir`
  endif
endfunction
