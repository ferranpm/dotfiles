if !exists("g:snippets")
  let g:snippets = {}
endif

inoremap <expr> <tab> TriggerSnippet()

let g:html_snippets = {
      \ "li": "<li></li>\<c-o>F<",
      \ "ul": "<ul>\<cr></ul>\<c-o>O",
      \ "ol": "<ol>\<cr></ol>\<c-o>O",
      \ "div": "<div>\<cr></div>\<c-o>O"
      \ }

let g:eruby_snippets = g:html_snippets
call extend(g:eruby_snippets, {
      \ "%": "<%  %>\<esc>Bhi",
      \ "%=": "<%=  %>\<esc>Bhi"
      \ })

let g:ruby_snippets = {
      \ "bp": "binding.pry",
      \ "ar": "attr_reader ",
      \ "defi": function("snippets#ruby#defi"),
      \ "class": "class \<c-r>=substitute(expand('%:t:r'), '\\m\\%(_\\|\\<\\)\\(\\l\\)', '\\U\\1', 'g')\<cr>\<cr>end\<c-o>O"
      \ }

function! TriggerSnippet()
  let trigger = matchstr(getline('.')[:col('.')-1], '\m\k\+$')
  let snippets = get(g:, &filetype . "_snippets", {})
  let backspaces = has_key(snippets, trigger) ? repeat("\<backspace>", len(trigger)) : ""
  let Expansion = get(snippets, trigger, "\<tab>")
  let completion = type(Expansion) == v:t_func ? call(Expansion, []) : Expansion
  return backspaces . completion
endfunction
