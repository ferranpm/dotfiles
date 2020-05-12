" http://vim.wikia.com/wiki/Custom_keyword_completion

function! autocomplete#complete(findstart, base)
  if a:findstart
    return autocomplete#find_start()
  else
    let l:regexp = autocomplete#regexp(a:base)
    call autocomplete#completions(l:regexp)
  endif
endfunction

function! autocomplete#find_start()
  let l:part = strpart(getline('.'), 0, col('.') - 1)
  return match(part, '\m\<\w*$')
endfunction

function! autocomplete#completions(regexp)
  let l:buffers = getbufinfo({ "bufloaded": 1 })

  for l:mode in split(&complete, ',')
    if l:mode == '.'
      call autocomplete#add_from_buffers(getbufinfo(bufnr()), a:regexp)
    elseif l:mode == 'w'
      call autocomplete#add_from_buffers(filter(l:buffers, '!empty(v:val["windows"]) && v:val["bufnr"] != bufnr()'), a:regexp)
    elseif l:mode == 'b'
      call autocomplete#add_from_buffers(filter(l:buffers, 'empty(v:val["windows"])'), a:regexp)
    elseif l:mode == 't' || l:mode == ']'
      call autocomplete#add_from_tags(a:regexp)
    endif
  endfor
endfunction

function! autocomplete#regexp(base)
  return '\C\<'.substitute(a:base, '\m\k\zs', '\\k*', "g").'\>'
endfunction

function! autocomplete#add_from_tags(regexp)
  for l:tag in taglist(a:regexp)
    call complete_add({ "word": l:tag["name"], "kind": l:tag["kind"] })
  endfor
endfunction

function! autocomplete#add_from_buffers(buffers, regexp)
  for l:buffer in a:buffers
    if complete_check()
      break
    endif

    if l:buffer["linecount"] > 5000
      continue
    endif

    call autocomplete#add_from_lines(getbufline(l:buffer["bufnr"], 0, '$'), a:regexp)
  endfor
endfunction

function! autocomplete#add_from_lines(lines, regexp)
  for word in split(join(a:lines), '\m\s*\<\|\>\s*')
    if word =~# a:regexp
      call complete_add(word)
    endif
  endfor
endfunction
