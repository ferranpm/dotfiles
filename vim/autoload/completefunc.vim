" http://vim.wikia.com/wiki/Custom_keyword_completion

function! completefunc#complete(findstart, base)
  if a:findstart
    return completefunc#find_start()
  else
    call completefunc#completions(a:base)
  endif
endfunction

function! completefunc#find_start()
  let l:part = strpart(getline('.'), 0, col('.') - 1)
  return match(part, '\m\<\w*$')
endfunction

function! completefunc#completions(base)
  let l:buffers = getbufinfo({ 'bufloaded': 1 })

  for l:mode in split(&complete, ',')
    if l:mode == '.'
      call completefunc#add_from_buffers(getbufinfo(bufnr()), a:base, '.')
    elseif l:mode == 'w'
      call completefunc#add_from_buffers(filter(copy(l:buffers), '!empty(v:val["windows"]) && v:val["bufnr"] != bufnr()'), a:base, 'w')
    elseif l:mode == 'b'
      call completefunc#add_from_buffers(filter(copy(l:buffers), 'empty(v:val["windows"])'), a:base, 'b')
    elseif l:mode == 't' || l:mode == ']'
      call completefunc#add_from_tags(completefunc#regexp(a:base), 't')
    endif
  endfor
endfunction

function! completefunc#add_from_tags(regexp, mode)
  for l:tag in taglist(a:regexp)
    call complete_add({ 'word': l:tag['name'], 'kind': l:tag['kind'], 'menu': a:mode })
  endfor
endfunction

function! completefunc#add_from_buffers(buffers, regexp, mode)
  for l:buffer in a:buffers
    if complete_check()
      break
    endif

    call completefunc#add_from_lines(getbufline(l:buffer['bufnr'], 0, '$'), a:regexp, a:mode)
  endfor
endfunction

function! completefunc#add_from_lines(lines, base, mode)
  let l:words = split(join(a:lines), '\m\s*\<\|\>\s*')
  for word in completefunc#matchfuzzy(words, a:base)
    call complete_add({ 'word': word, 'menu': a:mode })
  endfor
endfunction

function! completefunc#fuzzysearch(words, base)
  if exists('*matchfuzzy')
    return matchfuzzy(a:words, a:base)
  elseif executable('fzy')
    return completefunc#matchfzy(a:words, a:base)
  else
    return completefunc#matchfuzzy(a:words, a:base)
  endif
endfunction

function! completefunc#matchfuzzy(words, base)
  let l:regexp = completefunc#regexp(a:base)
  return filter(a:words, 'v:val =~ l:regexp')
endfunction

function! completefunc#matchfzy(words, base)
  return split(system("fzy --show-matches='".a:base."'", a:words))
endfunction

function! completefunc#regexp(base)
  return '^'.substitute(a:base, '\m\k\zs', '\\k*', 'g').'$'
endfunction
