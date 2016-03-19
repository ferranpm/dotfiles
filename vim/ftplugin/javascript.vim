setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2
setlocal foldmethod=indent
setlocal foldlevelstart=1

command! -buffer -nargs=0 Mocha  setlocal makeprg=mocha\ --reporter\ tap      errorformat=%Enot\ ok\ %n\ %.%#,%C%.%#AssertionError:\ %m,%Z%.%#(%f:%l:%c)
command! -buffer -nargs=0 JSCS   setlocal makeprg=jscs\ --reporter\ inline\ % errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
command! -buffer -nargs=0 JSHINT setlocal makeprg=jshint\ %                   errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m

Mocha

nnoremap <buffer> <silent> <c-]> :TernDef<cr>
