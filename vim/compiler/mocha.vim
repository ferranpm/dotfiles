if exists("current_compiler")
    finish
endif
let current_compiler = "mocha"

CompilerSet makeprg=mocha

CompilerSet errorformat=%E\ %#%n\)\ %.%#:
CompilerSet errorformat+=%C%.%\\{-}Error:\ %m
CompilerSet errorformat+=%C%.%\\{-}EvalError:\ %m
CompilerSet errorformat+=%C%.%\\{-}RangeError:\ %m
CompilerSet errorformat+=%C%.%\\{-}ReferenceError:\ %m
CompilerSet errorformat+=%C%.%\\{-}SyntaxError:\ %m
CompilerSet errorformat+=%C%.%\\{-}TypeError:\ %m
CompilerSet errorformat+=%Z\ %#\ at\ %f:%l:%c
CompilerSet errorformat+=%Z\ %#\ at\ %.%#\ (%f:%l:%c)
CompilerSet errorformat+=%Z%^%$
CompilerSet errorformat+=%C\ %m
CompilerSet errorformat+=%C%.%#
