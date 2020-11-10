if exists("current_compiler")
  finish
endif
let current_compiler = "pronto"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=bundle\ exec\ pronto\ run\ --commit\ master

CompilerSet errorformat=%f:%l\ %t:\ %m
