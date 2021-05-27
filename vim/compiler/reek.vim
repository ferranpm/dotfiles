if exists("current_compiler")
  finish
endif
let current_compiler = "reek"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=reek\ --single-line\ --no-progress

CompilerSet errorformat=%f:%l:\ %m
