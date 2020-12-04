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
      \ "sc": "<script>\<cr></script>\<c-o>O",
      \ "style": "<link rel=\"stylesheet\" type=\"text/css\" href=\"\">\<c-o>F\"",
      \ "st": "<style>\<cr></style>\<c-o>O",
      \ "title": "<title></title>\<c-o>F<",
      \ "h1": "<h1></h1>\<c-o>F<",
      \ "h2": "<h2></h2>\<c-o>F<",
      \ "h3": "<h3></h3>\<c-o>F<",
      \ "h4": "<h4></h4>\<c-o>F<",
      \ "h5": "<h5></h5>\<c-o>F<",
      \ "a": "<a href=\"\"></a>\<c-o>F\"",
      \ "nav": "<nav>\<cr></nav>\<c-o>O",
      \ "ul": "<ul>\<cr></ul>\<c-o>O",
      \ "ol": "<ol>\<cr></ol>\<c-o>O",
      \ "li": "<li></li>\<c-o>F<",
      \ "table": "<table>\<cr></table>\<c-o>O",
      \ "thead": "<thead>\<cr></thead>\<c-o>O",
      \ "tbody": "<tbody>\<cr></tbody>\<c-o>O",
      \ "tr": "<tr>\<cr></tr>\<c-o>O",
      \ "th": "<th></th>\<c-o>F<",
      \ "td": "<td></td>\<c-o>F<",
      \ "div": "<div>\<cr></div>\<c-o>O",
      \ "img": "<img src=\"\">\<c-o>F\""
      \ }

let g:snippets["eruby"] = g:snippets["html"]
call extend(g:snippets["eruby"], {
      \ "%": "<%  %>\<esc>Bhi",
      \ "%=": "<%=  %>\<esc>Bhi"
      \ })

let g:snippets["ruby"] = {
      \ "bp": "require \"pry\"; binding.pry",
      \ "ar": "attr_reader ",
      \ "defi": function("snippets#ruby#defi"),
      \ "class": "class \<c-r>=snippets#ruby#class_name()\<cr>\<cr>end\<c-o>O",
      \ "fsl": "# frozen_string_literal: true\<cr>\<c-w>",
      \ "rspec": "RSpec.describe \<c-r>=substitute(snippets#ruby#class_name(), 'Spec$', '', '')\<cr> do\<cr>end\<c-o>O",
      \ "describe": "describe \"\" do\<cr>end\<esc>k0f\"a",
      \ "context": "context \"\" do\<cr>end\<esc>k0f\"a",
      \ "it": "it \"\" do\<cr>end\<esc>k0f\"a",
      \ "info": "Rails.logger.info "
      \ }
let g:snippets["ruby"]["desc"] = g:snippets["ruby"]["describe"]
let g:snippets["ruby"]["ctx"] = g:snippets["ruby"]["context"]

let g:snippets["javascript"] = {
      \ "cl": "console.log();\<c-o>F)",
      \ "ce": "console.error();\<c-o>F)",
      \ "desc": "describe(, () => {\r});\<c-o>?,\<cr>",
      \ "it": "it(\"\", () => {\r});\<c-o>?\"\<cr>",
      \ }

let g:snippets["typescript"] = g:snippets["javascript"]

let g:snippets["javascript.jsx"] = g:snippets["javascript"]
let g:snippets["javascriptreact"] = g:snippets["javascript"]

let g:snippets["markdown"] = {
      \ "link": "[]()\<c-o>F]",
      \ }
let g:snippets["gitcommit"] = g:snippets["markdown"]
call extend(g:snippets["gitcommit"], {
      \ "co": "Co-authored-by:  <name@sequra.es>\<esc>F<hi",
      \ })

let g:snippets["svelte"] = extend(g:snippets["html"], g:snippets["javascript.jsx"])

function! TriggerSnippet()
  let trigger = matchstr(getline('.')[:col('.')-2], '\m\k\+$')
  let snippets = get(g:snippets, &filetype, {})
  let backspaces = has_key(snippets, trigger) ? repeat("\<backspace>", len(trigger)) : ""
  let Expansion = get(snippets, trigger, "\<tab>")
  let completion = type(Expansion) == v:t_func ? call(Expansion, []) : Expansion
  return backspaces . completion
endfunction
