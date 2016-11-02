try
    call tern#Enable()
catch
endtry

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal foldmethod=indent
setlocal foldlevelstart=1

nnoremap <buffer> <silent> ,i :update<cr>:MochaTest<cr>
nnoremap <buffer> <silent> ,d :update<cr>:MochaDescription<cr>
nnoremap <buffer> <silent> <c-RightMouse> <c-o>

if !exists('current_compiler')
    compiler mocha
endif
