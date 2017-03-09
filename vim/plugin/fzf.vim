let $FZF_DEFAULT_COMMAND= 'ag -g ""'
let g:fzf_buffers_jump=1
nnoremap <C-p> :Buffers<cr>
nnoremap <C-q> :FZF<cr>
nnoremap <C-s> :DeleteBuffers<cr>

function! s:list_buffers()
    redir => buffers
    silent ls
    redir END
    return split(buffers, "\n")
endfunction

function! s:delete_buffers(lines)
    let l:list = map(a:lines, 'matchstr(v:val, "[0-9]\\+")')
    for bufno in l:list
        silent! execute 'bd ' bufno
    endfor
endfunction

command! -bang DeleteBuffers
            \ call fzf#run(fzf#wrap({'source':  s:list_buffers(),
            \                        'options': '--multi --bind alt-a:select-all',
            \                        'sink*':   function('s:delete_buffers')}, <bang>0))
