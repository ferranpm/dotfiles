" http://vim.wikia.com/wiki/Custom_keyword_completion

function! completefunc#complete(findstart, base)
  if a:findstart
    return completefunc#find_start()
  else
    return completefunc#completions(a:base)
  endif
endfunction

function! completefunc#find_start()
  let l:part = strpart(getline('.'), 0, col('.') - 1)
  return match(part, '\m\<\w*$')
endfunction

function! completefunc#completions(base)
  let l:regexp = completefunc#regexp(a:base)

  for l:mode in split(&complete, ',')
    if complete_check()
      break
    endif

    if l:mode == '.'
      call completefunc#add_from_buffers(getbufinfo(bufnr()), l:regexp, '.')
    elseif l:mode == 'w'
      call completefunc#add_from_buffers(filter(getbufinfo({ 'bufloaded': 1 }), '!empty(v:val["windows"]) && v:val["bufnr"] != bufnr()'), l:regexp, 'w')
    elseif l:mode == 'b'
      call completefunc#add_from_buffers(filter(getbufinfo({ 'bufloaded': 1 }), 'empty(v:val["windows"]) && v:val["bufnr"] != bufnr()'), l:regexp, 'b')
    elseif l:mode == 't' || l:mode == ']'
      call completefunc#add_from_tags(l:regexp, 't')
    endif
  endfor
endfunction

function! completefunc#add_from_tags(regexp, mode)
  for l:tag in taglist(a:regexp, expand('%'))
    call complete_add({ 'word': l:tag['name'], 'kind': l:tag['kind'], 'menu': a:mode })
  endfor
endfunction

function! completefunc#add_from_buffers(buffers, regexp, mode)
  for l:buffer in a:buffers
    call completefunc#add_from_lines(getbufline(l:buffer['bufnr'], 1, '$'), a:regexp, a:mode)
  endfor
endfunction

function! completefunc#add_from_lines(lines, regexp, mode)
  let l:string = join(a:lines)
  if strlen(l:string) > 1024*1024 " 1M limit file size
    return
  endif
  let l:words = split(l:string, '\m\s*\<\|\>\s*')
  for l:word in completefunc#matchfuzzy(words, a:regexp)
    call complete_add({ 'word': l:word, 'menu': a:mode })
  endfor
endfunction

function! completefunc#matchfuzzy(words, regexp)
  return filter(a:words, 'v:val =~ a:regexp')
endfunction

function! completefunc#regexp(base)
  return '^'.substitute(a:base, '\m\k\zs', '\\k*', 'g').'$'
endfunction
