setlocal shiftwidth=4
setlocal softtabstop=4
setlocal tabstop=8
setlocal shiftround

setlocal makeprg=ghc\ -c\ %
setlocal errorformat=%f:%l:%c:\ %m,%E%f:%l:%c:,%C%m,%Z%m,%f:%l:%c:
