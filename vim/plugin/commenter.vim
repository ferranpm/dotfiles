noremap gc :call ToggleCommentLine(line("."))<cr>

let s:comments = {
            \ 'vim':    [ '" ', ''],
            \ 'c':      [ '/* ', ' */' ],
            \ 'cpp':    [ '// ', ''],
            \ 'html':   [ '<!--', '-->' ],
            \ 'sh':     [ '# ', '' ],
            \ 'php':    [ '// ', '' ],
            \ }

function! ToggleCommentLine(line)
    let l:cursor_save = [line('.'), col('.'), 0]
    if has_key(s:comments, &ft)
        let l:c_start = s:comments[&ft][0]
        let l:c_end = s:comments[&ft][1]
    else
        echo 'No comment symbols in s:comments'
        return
    endif
    let l:str = getline(a:line)
    if search('^ *'.escape(l:c_start, '*'), 'bc' , a:line) == 0
        let l:cursor_save[1] = l:cursor_save[1] + strlen(l:c_start)
        let str = l:c_start . l:str . l:c_end
        call setline(a:line, l:str)
    else
        for l:i in range(1, strlen(l:c_start))
            normal x
        endfor
        call search('\.*'.escape(l:c_end, '*').'$', 'c' , a:line)
        for l:i in range(1, strlen(l:c_end))
            normal x
        endfor
        let l:cursor_save[1] = l:cursor_save[1] - strlen(l:c_start)
    endif
    call cursor(l:cursor_save)
endfunction
