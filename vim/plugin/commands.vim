command! -nargs=0 Code !code . %
command! -nargs=0 Branches FzfLua git_branches
command! -nargs=1 -range Align '<,'>call edit#align(<f-args>)
