try
    call tern#Enable()
catch
endtry

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal foldmethod=indent
setlocal foldlevelstart=1

nnoremap <buffer> <silent> <c-]> :TernDef<cr>
nnoremap <buffer> <silent> <c-LeftMouse> <LeftMouse>:TernDef<cr>
nnoremap <buffer> <silent> <c-RightMouse> <c-o>
