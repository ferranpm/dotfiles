function! snippets#trigger()
  let trigger = matchstr(getline('.')[:col('.')-2], '\m\k\+$')
  let snippets = get(g:snippets, &filetype, {})

  let possible_snippets = sort(filter(keys(snippets), { i, val -> match(val, trigger) == 0 }))

  if trigger == ""
    return "\<tab>"
  elseif len(possible_snippets) == 0
    return ""
  elseif len(possible_snippets) == 1
    let snippet_name = possible_snippets[0]
  elseif !has_key(snippets, trigger)
    let options = copy(possible_snippets)
    call insert(options, "Cancel snippet insertion", 0)
    let input = inputlist(map(options, { i, val -> i . ". " . val })) - 1
    if input == -1
      return ""
    endif
    let snippet_name = possible_snippets[input]
  else
    let snippet_name = trigger
  endif

  let backspaces = repeat("\<backspace>", len(trigger))
  let Expansion = get(snippets, snippet_name, "\<tab>")
  let completion = type(Expansion) == v:t_func ? call(Expansion, []) : Expansion
  return backspaces . completion
endfunction
