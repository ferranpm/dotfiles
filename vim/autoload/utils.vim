function! utils#folder_complete(ArgLead, CmdLine, CursorPos, Folder)
    let expanded = expand(a:Folder) . '/'
    return join(map(glob(expanded.'*', 1, 1), 'substitute(v:val, expanded, "", "")'), "\n")
endfunction

function! utils#max_column(string, startline, endline, column)
  let l:cursor_save = getpos('.')
  let l:max_column = 0
  for line in range(a:endline - a:startline + 1)
    call cursor(a:startline + line, a:column)
    call search(a:string, 'c', line('.'))
    let l:current_column = col('.')
    if l:current_column > l:max_column
      let l:max_column = l:current_column
    endif
  endfor
  call setpos('.', l:cursor_save)
  return l:max_column
endfunction

function! utils#sudo_write() abort
  execute (has('gui_running') ? '' : 'silent') 'write !env SUDO_EDITOR=tee sudo -e % >/dev/null'
  let &modified = v:shell_error
endfunction

function! utils#indent() range
  if a:firstline == a:lastline
    normal ==
  else
    normal gv=
  endif
endfunction

" utils#go_to_buffer({name}[, {methodnew}[, {switchbuf}]])
function! utils#go_to_buffer(name, ...) " {{{
    let methodnew = 'tabnew'
    let switchbuf = 'usetab'
    let oldswitchbuf = &switchbuf
    if a:0 > 0 | let methodnew = a:1 | endif
    if a:0 > 1 | let switchbuf = a:2 | endif
    if bufexists(a:name)
        execute 'set switchbuf='.switchbuf
        execute 'sbuffer '.a:name
        execute 'set switchbuf='.oldswitchbuf
    else
        execute methodnew
        execute 'file '.a:name
    endif
endfunction " }}}
