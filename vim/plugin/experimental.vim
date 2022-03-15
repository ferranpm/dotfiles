augroup Experimental
  autocmd!
  autocmd BufWritePost *.rb call s:update_ruby_ctags(expand("<afile>"))
  autocmd FocusGained * checktime
  autocmd BufReadPost * cd .
augroup END

let s:last_update_ruby_ctags = reltimefloat(reltime())

function! s:update_ruby_ctags(file)
  if a:file =~ '_spec.rb$'
    return
  endif

  let current_time = reltimefloat(reltime())
  if current_time - s:last_update_ruby_ctags < 0.5
    return
  endif
  let s:last_update_ruby_ctags = current_time

  let command = 'ripper-tags --recursive --append --exclude=vendor ' . a:file

  if has('nvim')
    call jobstart(command)
  else
    call job_start(command)
  end
endfunction

command! OpenInVSCode exe "silent !code '" . getcwd() . "' --goto '" . expand("%") . ":" . line(".") . ":" . col(".") . "'" | redraw!

let g:loaded_ruby_provider = 0
let g:loaded_node_provider = 0
let g:loaded_perl_provider = 0
