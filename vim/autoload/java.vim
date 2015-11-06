function! java#is_unused_import()
    let cur = getpos('.')
    normal! f;b*
    let val = getpos('.')[1] == cur[1]
    call setpos('.', cur)
    return val
endfunction

function! java#delete_unused_imports()
    let cur = getpos('.')
    normal! gg
    while search('\m^\<import\> ', 'W') > 0
        if java#is_unused_import()
            normal! ddk
            if getpos('.')[1] < cur[1]
                let cur[1] = cur[1] - 1
            endif
        endif
    endwhile
    call setpos('.', cur)
endfunction
