function! autopairs#surrounded(current_char, previous_char)
    return
                \ index(values(g:pairs), a:current_char) >= 0 &&
                \ index(keys(g:pairs), a:previous_char) >= 0
endfunction

function! autopairs#insert(key)
    let line = getline('.')
    let position = col('.') - 1
    let current_char = get(split(strpart(line, position), '\zs'), 0, '')
    let previous_chars = split(strpart(line, 0, position), '\zs')
    let previous_char = get(previous_chars, -1, '')

    if a:key == 'bs'
        return autopairs#surrounded(current_char, previous_char) ? "\<esc>xs" : "\<bs>"
    endif

    if a:key == 'cr'
        let extra = autopairs#surrounded(current_char, previous_char) ? "\<esc>O" : ""
        return "\<cr>".extra
    endif

    if a:key == ' '
        let extra = autopairs#surrounded(current_char, previous_char) ? " \<esc>i" : ""
        return " " . extra
    endif

    if current_char == a:key
        return "\<right>"
    endif

    if previous_char =~ '\S' || current_char =~ '\S'
        return a:key
    endif

    if !has_key(g:pairs, a:key)
        return a:key
    endif

    return a:key . g:pairs[a:key] . "\<esc>i"
endfunction

