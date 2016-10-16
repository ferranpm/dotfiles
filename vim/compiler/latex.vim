if exists("current_compiler")
    finish
endif
let current_compiler = "latex"

CompilerSet makeprg=pdflatex\ -file-line-error\ -interaction=nonstopmode\ %
CompilerSet errorformat=%f:%l:\ %m,\ %#l%.%l\ %m
