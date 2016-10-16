if exists("current_compiler")
    finish
endif
let current_compiler = "javascript"

CompilerSet makeprg=~/.vim/compiler/javascript\ %
CompilerSet errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
