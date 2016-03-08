setlocal shiftwidth=8
setlocal softtabstop=8
setlocal tabstop=8

setlocal makeprg=ghc\ -c\ %
setlocal errorformat=%f:%l:%c:\ %m,%E%f:%l:%c:,%C%m,%Z%m,%f:%l:%c:
