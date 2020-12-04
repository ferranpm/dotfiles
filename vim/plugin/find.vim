command! -nargs=1 -bang -complete=customlist,FindComplete Find edit<bang> <args>

function! FindComplete(A,L,P)
  let extension = stridx(a:A, '.') >= 0 ? '' : '*.\(rb\|html.erb\|js\)'
  let regex = tolower(join(split(a:A, '\zs'), "*")) . extension

  return uniq(sort(
        \   map(
        \     globpath(&path, regex, v:true, v:true),
        \     { _, e -> fnamemodify(e, ':.') }
        \   ),
        \   { a, b -> strchars(a) - strchars(b) }
        \ ))
endfunction
