if exists("current_compiler")
  finish
endif
let current_compiler = "rubocop"

if exists(":CompilerSet") != 2
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=bundle\ exec\ rubocop\ --format\ emacs\ --config\ .rubocop.yml\ %

CompilerSet errorformat=%f:%l:%c:\ %t:\ %m
