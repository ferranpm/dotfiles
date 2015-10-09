command! -nargs=1 -complete=help Help if &ft=~'help' | help <args> | else | tab help <args> | endif
command! -nargs=+ Grep silent grep! <args> * | redraw!

command! -nargs=1 -complete=file E call utils#OpenWithHeader(<f-args>)
command! -nargs=? -complete=dir Mkdir call utils#Mkdir(<f-args>)
command! -nargs=+ -complete=command Pipe call utils#Pipe(<q-args>)
command! -nargs=+ -complete=shellcmd Shell call utils#Shell(<q-args>)
command! SudoWrite call utils#SudoWriteCmd()

command! -nargs=? UnderscoreToUpperCamelCase <args>s#\m\(\%(\<\l\+\)\%(_\)\@=\)\|_\(\l\)#\u\1\2
command! -nargs=? UnderscoreToLowerCamelCase <args>s#\m_\(\l\)#\u\1
command! -nargs=? CamelCaseToUnderscore <args>s#\m\C\(\<\u[a-z0-9]\+\|[a-z0-9]\+\)\(\u\)#\l\1_\l\2

command! -nargs=1 -range Align '<,'>call edit#Align(<f-args>)
command! -nargs=0 JSONFormatter call edit#JSONFormatter()
command! -nargs=0 Reg call edit#Reg()

command! -nargs=0 Picocom call serial#Picocom()

function! s:ScriptComplete(ArgLead, CmdLine, CursorPos)
    return utils#FolderComplete(a:ArgLead, a:CmdLine, a:CursorPos, "~/.vim/scripts/")
endfunction
command! -nargs=1 -complete=custom,s:ScriptComplete Script source ~/.vim/scripts/<args>
