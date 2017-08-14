try
    call tern#Enable()
catch
endtry

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

nnoremap <buffer> <silent> ,i :update<cr>:MochaTest<cr>
nnoremap <buffer> <silent> ,d :update<cr>:MochaDescription<cr>
nnoremap <buffer> <silent> <c-RightMouse> <c-o>
nnoremap <buffer> <silent> <c-]> :TernDef<cr>
nnoremap <buffer> <silent> <c-LeftMouse> <LeftMouse>:TernDef<cr>

if !exists('current_compiler')
    compiler javascript
endif
