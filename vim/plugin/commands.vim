command! -nargs=0 Code !code . %
command! -nargs=0 Branches call fzf#run({'source': "git branch | sed -E 's/^\\*? +//'", 'sink': '!git checkout'})
command! -nargs=1 -range Align '<,'>call edit#align(<f-args>)
