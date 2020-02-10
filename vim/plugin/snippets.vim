if !exists("g:snippets")
  let g:snippets = {}
endif

inoremap <expr> <tab> TriggerSnippet()

let g:snippets["html"] = {
      \ "html": "<html>\<cr></html>\<c-o>O",
      \ "head": "<head>\<cr></head>\<c-o>O",
      \ "body": "<body>\<cr></body>\<c-o>O",
      \ "header": "<header>\<cr></header>\<c-o>O",
      \ "main": "<main>\<cr></main>\<c-o>O",
      \ "meta": "<meta charset=\"UTF-8\">",
      \ "viewport": "<meta name=\"viewport\" content=\"width=device-width\">",
      \ "script": "<script src=\"\"></script>\<c-o>F\"",
      \ "style": "<link rel=\"stylesheet\" href=\"\">\<c-o>F\"",
      \ "title": "<title></title>\<c-o>F<",
      \ "h1": "<h1></h1>\<c-o>F<",
      \ "h2": "<h2></h2>\<c-o>F<",
      \ "h3": "<h3></h3>\<c-o>F<",
      \ "h4": "<h4></h4>\<c-o>F<",
      \ "h5": "<h5></h5>\<c-o>F<",
      \ "a": "<a href=\"\"></a>\<c-o>F\"",
      \ "ul": "<ul>\<cr></ul>\<c-o>O",
      \ "ol": "<ol>\<cr></ol>\<c-o>O",
      \ "li": "<li></li>\<c-o>F<",
      \ "table": "<table>\<cr></table>\<c-o>O",
      \ "tr": "<tr>\<cr></tr>\<c-o>O",
      \ "th": "<th></th>\<c-o>F<",
      \ "td": "<td></td>\<c-o>F<",
      \ "div": "<div>\<cr></div>\<c-o>O",
      \ }

let g:snippets["eruby"] = g:snippets["html"]
call extend(g:snippets["eruby"], {
      \ "%": "<%  %>\<esc>Bhi",
      \ "%=": "<%=  %>\<esc>Bhi"
      \ })

let g:snippets["ruby"] = {
      \ "bp": "binding.pry",
      \ "ar": "attr_reader ",
      \ "defi": function("snippets#ruby#defi"),
      \ "class": "class \<c-r>=substitute(expand('%:t:r'), '\\m\\%(_\\|\\<\\)\\(\\l\\)', '\\U\\1', 'g')\<cr>\<cr>end\<c-o>O"
      \ }

let g:snippets["javascript"] = {
      \ "cl": "console.log();\<c-o>F)",
      \ "ce": "console.error();\<c-o>F)",
      \ "desc": "describe(, () => {\r});\<c-o>?,\<cr>",
      \ "it": "it(\"\", () => {\r});\<c-o>?\"\<cr>",
      \ }

let g:snippets["typescript"] = g:snippets["javascript"]

let g:snippets["javascript.jsx"] = g:snippets["javascript"]

function! TriggerSnippet()
  let trigger = matchstr(getline('.')[:col('.')-1], '\m\k\+$')
  let snippets = get(g:snippets, &filetype, {})
  let backspaces = has_key(snippets, trigger) ? repeat("\<backspace>", len(trigger)) : ""
  let Expansion = get(snippets, trigger, "\<tab>")
  let completion = type(Expansion) == v:t_func ? call(Expansion, []) : Expansion
  return backspaces . completion
endfunction
