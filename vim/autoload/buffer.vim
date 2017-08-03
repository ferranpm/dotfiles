let s:ft_to_header = {
            \ 'c': ['h'],
            \ 'cpp': ['h', 'hpp', 'hh']
            \ }
let s:header_to_source = {
            \ 'h': ['c', 'cpp'],
            \ 'hpp': ['cpp'],
            \ 'hh': ['cc', 'cpp']
            \ }

function! buffer#AlternateSource() " {{{
    let filebase = expand('%:r')
    let extension = expand('%:e')
    let file = ''
    let extensions = []
    if has_key(s:header_to_source, extension)
        let extensions = s:header_to_source[extension]
    elseif has_key(s:ft_to_header, &ft)
        let extensions = s:ft_to_header[&ft]
    endif
    for ext in extensions
        let file = filebase.'.'.ext
        if filereadable(file)
            execute 'e '.file
            return
        endif
    endfor
endfunction " }}}

function! buffer#AlternateFile() " {{{
    try
        buffer #
    catch
        bprevious
    endtry
endfunction " }}}

function! buffer#BufferDelete() " {{{
    call buffer#AlternateFile()
    try
        bdelete #
    catch
        bdelete
    endtry
endfunction " }}}

function! buffer#BufferWipeOut() " {{{
    call buffer#AlternateFile()
    try
        bwipeout #
    catch
        bwipeout
    endtry
endfunction " }}}

function! buffer#BufferKill() " {{{
    let l:count = 0
    for b in range(1, bufnr('$'))
        if bufexists(b) && !buflisted(b)
            execute 'bdelete '.b
            let l:count += 1
        endif
    endfor
    echo 'Deleted ' . l:count . ' buffers'
endfunction " }}}

function! buffer#SetProjectRoot() " {{{
    cd %:p:h
    let git_dir = system('git rev-parse --show-toplevel')
    let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
    if empty(is_not_git_dir)
        cd `=git_dir`
    endif
endfunction " }}}

" GoToBuffer({name}[, {methodnew}[, {switchbuf}]])
function! buffer#GoToBuffer(name, ...) " {{{
    let methodnew = 'tabnew'
    let switchbuf = 'usetab'
    let oldswitchbuf = &switchbuf
    if a:0 > 0 | let methodnew = a:1 | endif
    if a:0 > 1 | let switchbuf = a:2 | endif
    if bufexists(a:name)
        execute 'set switchbuf='.switchbuf
        execute 'sbuffer '.a:name
        execute 'set switchbuf='.oldswitchbuf
    else
        execute methodnew
        execute 'file '.a:name
    endif
endfunction " }}}
