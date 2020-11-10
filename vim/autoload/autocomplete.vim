" http://vim.wikia.com/wiki/Custom_keyword_completion

function! autocomplete#complete(findstart, base)
  if a:findstart
    return autocomplete#find_start()
  else
    call autocomplete#completions(a:base)
  endif
endfunction

function! autocomplete#find_start()
  let l:part = strpart(getline('.'), 0, col('.') - 1)
  return match(part, '\m\<\w*$')
endfunction

function! autocomplete#completions(regexp)
  let l:buffers = getbufinfo({ 'bufloaded': 1 })

  for l:mode in split(&complete, ',')
    if l:mode == '.'
      call autocomplete#add_from_buffers(getbufinfo(bufnr()), a:regexp, '.')
    elseif l:mode == 'w'
      call autocomplete#add_from_buffers(filter(copy(l:buffers), '!empty(v:val["windows"]) && v:val["bufnr"] != bufnr()'), a:regexp, 'w')
    elseif l:mode == 'b'
      call autocomplete#add_from_buffers(filter(copy(l:buffers), 'empty(v:val["windows"])'), a:regexp, 'b')
    elseif l:mode == 't' || l:mode == ']'
      call autocomplete#add_from_tags(a:regexp, 't')
    endif
  endfor

  call autocomplete#add_from_lines(keys(get(g:snippets, &filetype, {})), a:regexp, 'snippet')
endfunction

function! autocomplete#regexp(base)
  return '\<'.substitute(a:base, '\m\k\zs', '\\k*', 'g').'\>'
endfunction

function! autocomplete#add_from_tags(regexp, mode)
  for l:tag in taglist(a:regexp)
    call complete_add({ 'word': l:tag['name'], 'kind': l:tag['kind'], 'menu': a:mode })
  endfor
endfunction

function! autocomplete#add_from_buffers(buffers, regexp, mode)
  for l:buffer in a:buffers
    if complete_check()
      break
    endif

    if get(l:buffer, 'linecount') > 2500
      continue
    endif

    call autocomplete#add_from_lines(getbufline(l:buffer['bufnr'], 0, '$'), a:regexp, a:mode)
  endfor
endfunction

function! autocomplete#add_from_lines(lines, base, mode)
  if has('nvim')
    let l:regexp = autocomplete#regexp(a:base)
    for word in split(join(a:lines), '\m\s*\<\|\>\s*')
      if word =~ l:regexp
        call complete_add({ 'word': word, 'menu': a:mode })
      endif
    endfor
  else
    for word in matchfuzzy(split(join(a:lines), '\m\s*\<\|\>\s*'), a:base)
      call complete_add({ 'word': word, 'menu': a:mode })
    endfor
  endif
endfunction
