function! edit#reg()
    reg
    echo 'Register: '
    let char = nr2char(getchar())
    if char != "\<Esc>"
        execute 'normal! "'.char.'p'
    endif
    redraw
endfunction

function! edit#align(string) range
    let col = min([ virtcol("'<"), virtcol("'>") ])
    let l:cursor_save = getpos('.')
    let l:max_column = utils#max_column(a:string, a:firstline, a:lastline, col)
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
endfunction

function! edit#auto_highlight_toggle()
    if exists('#auto_highlight')
        match none IncSearch
        autocmd! auto_highlight
        augroup! auto_highlight
        augroup END
        echo 'Highlight current word: OFF'
    else
        augroup auto_highlight
            autocmd! CursorHold * exe printf('match IncSearch /\V\<%s\>/', escape(expand('<cword>'), '/\'))
        augroup END
        echo 'Highlight current word: ON'
    endif
endfunction

function! edit#quickfix_to_args()
  execute 'args '.join(filter(uniq(map(getqflist(), 'bufname(v:val["bufnr"])')), 'v:val !~ "^\s*$"'), ' ')
endfunction
