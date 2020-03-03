command! -nargs=+ -bang -complete=customlist,FindComplete Find edit<bang> <args>

function! Distance(name, i, substr, j)
  if a:i == strchars(a:name)   | return strchars(a:substr) | endif
  if a:j == strchars(a:substr) | return strchars(a:name)   | endif

  if tolower(a:name[a:i]) == tolower(a:substr[a:j])
    return Distance(a:name, a:i + 1, a:substr, a:j + 1)
  else
    return Distance(a:name, a:i + 1, a:substr, a:j) + 1
  end
endfunction

function! FindComplete(A,L,P)
  let regex = tolower(join(split(a:A, '\zs'), "*")) . "*"

  return uniq(sort(
        \   map(
        \     filter(
        \       globpath(&path, regex, v:true, v:true),
        \       { _, item -> !isdirectory(item) }
        \     ),
        \     { _, e -> fnamemodify(e, ':.') }
        \   ),
        \   { a, b -> Distance(a, 0, a:A, 0) - Distance(b, 0, a:A, 0) }
        \ ))
endfunction

nnoremap <c-q> :Find 
