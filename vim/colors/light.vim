set background=light

highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
    syntax reset
endif

set t_Co=256

let colors_name = "light"

highlight ColorColumn      term=NONE cterm=NONE             ctermbg=224
highlight Comment          term=NONE cterm=NONE ctermfg=10
highlight Conceal          term=NONE cterm=NONE ctermfg=7   ctermbg=242
highlight Constant         term=NONE cterm=NONE ctermfg=1
highlight CursorColumn     term=NONE cterm=NONE             ctermbg=7
highlight CursorLine       term=NONE cterm=NONE             ctermbg=254
highlight CursorLineNr     term=NONE cterm=NONE ctermfg=0
highlight DiffAdd          term=NONE cterm=NONE             ctermbg=81
highlight DiffChange       term=NONE cterm=NONE             ctermbg=225
highlight DiffDelete       term=NONE cterm=NONE ctermfg=12  ctermbg=159
highlight DiffText         term=NONE cterm=NONE             ctermbg=9
highlight Directory        term=NONE cterm=NONE ctermfg=4
highlight Error            term=NONE cterm=NONE ctermfg=15  ctermbg=9
highlight ErrorMsg         term=NONE cterm=NONE ctermfg=15  ctermbg=1
highlight FoldColumn       term=NONE cterm=NONE ctermfg=4   ctermbg=15
highlight Folded           term=NONE cterm=NONE ctermfg=12  ctermbg=254
highlight Identifier       term=NONE cterm=NONE ctermfg=14
highlight Ignore           term=NONE cterm=NONE ctermfg=15
highlight IncSearch        term=NONE cterm=NONE ctermfg=0   ctermbg=2
highlight LineNr           term=NONE cterm=NONE ctermfg=0
highlight MatchParen       term=NONE cterm=NONE             ctermbg=14
highlight MoreMsg          term=NONE cterm=NONE ctermfg=2
highlight NonText          term=NONE cterm=NONE ctermfg=12
highlight Normal           term=NONE cterm=NONE ctermfg=0   ctermbg=15
highlight Pmenu            term=NONE cterm=NONE ctermfg=0   ctermbg=225
highlight PmenuSbar        term=NONE cterm=NONE             ctermbg=248
highlight PmenuSel         term=NONE cterm=NONE ctermfg=0   ctermbg=254
highlight PmenuThumb       term=NONE cterm=NONE             ctermbg=0
highlight PreProc          term=NONE cterm=NONE ctermfg=5
highlight Question         term=NONE cterm=NONE ctermfg=2
highlight Search           term=NONE cterm=NONE             ctermbg=3
highlight SignColumn       term=NONE cterm=NONE ctermfg=4   ctermbg=15
highlight Special          term=NONE cterm=NONE ctermfg=5
highlight SpecialKey       term=NONE cterm=NONE ctermfg=4
highlight SpellBad         term=NONE cterm=NONE             ctermbg=224
highlight SpellCap         term=NONE cterm=NONE             ctermbg=81
highlight SpellLocal       term=NONE cterm=NONE             ctermbg=14
highlight SpellRare        term=NONE cterm=NONE             ctermbg=225
highlight Statement        term=NONE cterm=NONE ctermfg=131
highlight StatusLine       term=NONE cterm=NONE ctermfg=231 ctermbg=16
highlight TabLine          term=NONE cterm=NONE ctermfg=15  ctermbg=0
highlight Title            term=NONE cterm=NONE ctermfg=5
highlight Todo             term=NONE cterm=NONE ctermfg=0   ctermbg=11
highlight Type             term=NONE cterm=NONE ctermfg=4
highlight Underlined       term=NONE cterm=NONE ctermfg=5
highlight Visual           term=NONE cterm=NONE             ctermbg=254
highlight WarningMsg       term=NONE cterm=NONE ctermfg=1
highlight WildMenu         term=NONE cterm=NONE ctermfg=0   ctermbg=11

highlight link Boolean         Constant
highlight link Character       Constant
highlight link Conditional     Statement
highlight link Debug           Special
highlight link Define          PreProc
highlight link Delimiter       Special
highlight link Exception       Statement
highlight link Float           Number
highlight link Function        Identifier
highlight link Include         PreProc
highlight link Keyword         Statement
highlight link Label           Statement
highlight link Macro           PreProc
highlight link Number          Constant
highlight link Operator        Statement
highlight link PreCondit       PreProc
highlight link Repeat          Statement
highlight link SpecialChar     Special
highlight link SpecialComment  Special
highlight link StorageClass    Type
highlight link String          Constant
highlight link Structure       Type
highlight link Tag             Special
highlight link Typedef         Type
