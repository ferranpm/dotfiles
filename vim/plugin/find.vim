command! -nargs=+ -bang -complete=customlist,FindComplete Find edit<bang> <args>

function! FindComplete(A,L,P)
  let regex = join(split(a:A, '\zs'), "*") . "*"
  let files = globpath(&path, regex, v:true, v:true)
  let files = filter(files, { _, item -> !isdirectory(item) })
  let files = map(files, { _, e -> fnamemodify(e, ':.') })
  let files = uniq(sort(files))

  return sort(files, { a, b -> strlen(a) - strlen(b) })
endfunction

nnoremap <c-q> :Find 
