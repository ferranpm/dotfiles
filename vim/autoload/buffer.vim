let s:ft_to_header = {
            \ 'c': ['h'],
            \ 'cpp': ['h', 'hpp']
            \ }
let s:header_to_source = {
            \ 'h': ['c', 'cpp'],
            \ 'hpp': ['cpp']
            \ }
function! buffer#OpenWithHeader(file) " {{{
    wincmd o
    execute 'e '.a:file
    let extension = expand('%:e')
    let filebase = expand('%:r')
    if has_key(s:header_to_source, extension)
        let extensions = s:header_to_source[extension]
    elseif has_key(s:ft_to_header, &ft)
        let extensions = s:ft_to_header[&ft]
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
        for b in reverse(range(1, bufnr('$')))
            if bufexists(b) && buflisted(b) && b != bufnr('%')
                execute 'buffer '.b
                return
            endif
        endfor
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
            execute 'bwipeout '.b
            let l:count += 1
        endif
    endfor
    echo 'Deleted ' . l:count . ' buffers'
endfunction " }}}

function! buffer#SetProjectRoot() " {{{
    lcd %:p:h
    let git_dir = system('git rev-parse --show-toplevel')
    let is_not_git_dir = matchstr(git_dir, '^fatal:.*')
    if empty(is_not_git_dir)
        lcd `=git_dir`
    endif
endfunction " }}}

" GoToBuffer({name}[, {methodnew}[, {switchbuf}]])
function! buffer#GoToBuffer(name, ...) " {{{
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
