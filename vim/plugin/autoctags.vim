let g:ctags_files = []
let g:ctags_timer = v:null

augroup AutoCtags
  autocmd!
  autocmd VimEnter * call s:initialize_ctags(1)
  autocmd FocusGained * call s:initialize_ctags(1)
  autocmd BufWritePost *.rb,*.ex,*.exs,*.cs,*.gd call s:update_ctags(expand("<afile>"))
augroup END

function! s:should_execute_ctags()
  call system('git rev-parse --show-toplevel')

  return v:shell_error == 0
endfunction

function! s:git_root()
  return systemlist('git rev-parse --show-toplevel')[0]
endfunction

function! s:tag_file()
  return s:git_root() . "/tags"
endfunction

function! s:initialize_ctags(_timer_id)
  if !s:should_execute_ctags()
    return
  endif

  call s:enqueue_command([ "ctags", "-R", "-f", s:tag_file() ])
  let g:ctags_files = []
  let g:ctags_timer = v:null
endfunction

function! s:update_ctags(file)
  call add(g:ctags_files, a:file)

  if g:ctags_timer == v:null
    let g:ctags_timer = timer_start(500, 's:initialize_ctags')
  endif
endfunction

function! s:enqueue_command(command)
  if exists("*jobstart")
    call jobstart(a:command)
  else
    call job_start(a:command)
  end
endfunction
