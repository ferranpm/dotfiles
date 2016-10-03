set makeprg=mocha

set errorformat=%E\ %#%n\)\ %.%#:
set errorformat+=%C%.%\\{-}Error:\ %m
set errorformat+=%Z\ %#\ at\ %f:%l:%c
set errorformat+=%Z\ %#\ at\ %.%#\ (%f:%l:%c)
set errorformat+=%Z%^%$
set errorformat+=%C%.%#
