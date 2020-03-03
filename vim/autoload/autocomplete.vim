" http://vim.wikia.com/wiki/Custom_keyword_completion

function! autocomplete#complete(findstart, base)
  if a:findstart
    return autocomplete#find_start()
  else
    return autocomplete#completions(a:base)
  endif
endfunction

function! autocomplete#find_start()
  let l:part = strpart(getline('.'), 0, col('.') - 1)
  return match(part, '\m\<\w*$')
endfunction

function! autocomplete#completions(base)
  let l:regex = autocomplete#regexp(a:base)
  let l:list = autocomplete#get_all_words_matching(l:regex)
  return sort(l:list, { a, b -> len(a) - len(b) })
endfunction

function! autocomplete#regexp(base)
  return '\<'.substitute(a:base, '\m\k\zs', '\\k*', "g").'\>'
endfunction

function! autocomplete#get_all_words_matching(regexp)
  let l:list = []
  let Split = { _, line -> split(line, '\m\s*\<\|\>\s*') }
  let Matching = { _, word -> word =~# '\c' . a:regexp }

  for buffer in getbufinfo(#{ buflisted: 1 })
    let lines = getbufline(buffer.bufnr, 0, '$')
    for words in map(lines, Split)
      call extend(l:list, filter(words, Matching))
    endfor
  endfor

  return l:list
endfunction
