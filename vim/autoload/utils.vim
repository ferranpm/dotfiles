function! utils#Run(cmd, args)
    if exists(':Dispatch') == 2
        execute 'Dispatch '.a:cmd.' '.a:args
    else
        execute '!'.a:cmd.' '.a:args
    endif
    cclose
endfunction

