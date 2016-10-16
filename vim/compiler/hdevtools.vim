if exists("current_compiler")
    finish
endif
let current_compiler = "hdevtools"

CompilerSet makeprg=hdevtools\ check\ %
CompilerSet errorformat=%E%f:%l:%c:\ %m
CompilerSet errorformat+=%Z\ %#%m
