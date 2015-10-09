function! utils#Run(cmd, args)
    if exists('*VimuxRunCommand') == 1
        call VimuxRunCommand(a:cmd.' '.a:args)
    else
        execute '!'.a:cmd.' '.a:args
    endif
endfunction

function! utils#Pipe(cmd)
    call buffer#GoToBuffer('Pipe', 'vnew')
    normal ggdG
    redir @+>
    silent execute a:cmd
    redir END
    silent 0put +
    normal! ggdd
    set nomodified
endfunction

function! utils#Shell(cmd)
    call buffer#GoToBuffer('Shell', 'vnew')
    normal! ggdG
    execute 'read !'.a:cmd
    normal! ggdd
    set nomodified
endfunction

function! utils#FolderComplete(ArgLead, CmdLine, CursorPos, Folder)
    let expanded = expand(a:Folder) . '/'
    return join(map(glob(expanded.'*', 1, 1), 'substitute(v:val, expanded, "", "")'), "\n")
endfunction

" FindUsage([{recursive} [, {pattern} [, {path}]]])
function! utils#FindUsage(...)
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
endfunction

function! utils#MaxColumn(string, startline, endline, column)
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

function! utils#SudoWriteCmd() abort
    execute (has('gui_running') ? '' : 'silent') 'write !env SUDO_EDITOR=tee sudo -e % >/dev/null'
    let &modified = v:shell_error
endfunction

function! utils#Make()
    update
    let make = exists(':Make') == 2 ? 'Make ' : 'make '
    if filereadable('Makefile') || filereadable('AndroidManifest.xml')
        execute make
    elseif expand('%:e') == 'ino'
        execute make.'%'
    else
        execute make.expand('%:r')
    endif
endfunction

function! utils#Mkdir(...)
    let folder = a:0 > 0 ? a:1 : '%:h'
    call system('mkdir -p '.expand(folder))
endfunction
