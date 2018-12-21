" http://vim.wikia.com/wiki/Custom_keyword_completion

function! autocomplete#complete(findstart, base)
  if a:findstart
    " locate start column of word
    let line = strpart(getline('.'), 0, col('.') - 1)
    return autocomplete#find_start(line, g:mkw_any)
  else
    let l:list = filter(autocomplete#get_all_words(), "v:val =~# s:regex")
    return sort(sort(l:list), { a, b -> len(a) - len(b) })
  endif
endfunction

" find start of keyword-match (return) and create regexp for finding matching keyword (s:regex)
" a:line - string to search in, search starts at end of string
" a:anyre - reg.exp looked for to be replaced by '\k\*'
function! autocomplete#find_start(line, anyre)
  " this can not be used because a:anyre could be 0-length:
  " return match(a:line, '\%(\k*'.a:anyre.'\)*\k*$')
  let line = a:line
  " trims trailing keyword-characters
  let result = match(line, '\k*$')
  if result < 0
    let result = strlen(line)
  else
    let line = strpart(line, 0, result)
  endif
  " trim trailing occurrences of keyword-characters followed by anyre
  while result > 0
    let result = match(line, '\k*'.a:anyre.'$')
    if result < 0 || result == strlen(line) | break | endif
    let line = strpart(line, 0, result)
  endwhile
  let result = strlen(line)
  let line = strpart(a:line, result)
  let s:regex = '\<'.substitute(line, a:anyre, '\\k*', "g").'\>'
  return result
endfunction

function! autocomplete#get_all_words()
  let l:list = []
  let buffers = filter(getbufinfo(), "buflisted(v:val['bufnr']) && bufloaded(v:val['bufnr'])")
  for buffer in buffers
    let lines = getbufline(buffer['bufnr'], 0, '$')
    for line in lines
      let words = split(line, '\s*\<\|\>\s*')
      call extend(l:list, words)
    endfor
  endfor
  return l:list
endfunction
