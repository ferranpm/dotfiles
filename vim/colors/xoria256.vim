set background=dark

highlight clear

" Load the syntax highlighting defaults, if it's enabled.
if exists("syntax_on")
    syntax reset
endif

set t_Co=256

let colors_name = "xoria256"

highlight Comment        term=NONE cterm=NONE      ctermfg=244
highlight Constant       term=NONE cterm=NONE      ctermfg=229
highlight Cursor         term=NONE cterm=NONE                  ctermbg=214
highlight CursorColumn   term=NONE cterm=NONE                  ctermbg=238
highlight CursorLine     term=NONE cterm=NONE                  ctermbg=237
highlight Directory      term=NONE cterm=NONE      ctermfg=110
highlight Error          term=NONE cterm=NONE      ctermfg=15  ctermbg=1
highlight ErrorMsg       term=NONE cterm=NONE      ctermfg=15  ctermbg=1
highlight FoldColumn     term=NONE cterm=NONE      ctermfg=247 ctermbg=233
highlight Folded         term=NONE cterm=NONE      ctermfg=255 ctermbg=60
highlight Identifier     term=NONE cterm=NONE      ctermfg=182
highlight Ignore         term=NONE cterm=NONE      ctermfg=238
highlight IncSearch      term=NONE cterm=NONE      ctermfg=0   ctermbg=223
highlight LineNr         term=NONE cterm=NONE      ctermfg=247 ctermbg=233
highlight MatchParen     term=NONE cterm=bold      ctermfg=188 ctermbg=68
highlight NonText        term=NONE cterm=bold      ctermfg=247 ctermbg=233
highlight Normal         term=NONE cterm=NONE      ctermfg=252 ctermbg=233
highlight Number         term=NONE cterm=NONE      ctermfg=180
highlight Pmenu          term=NONE cterm=NONE      ctermfg=0   ctermbg=250
highlight PmenuSbar      term=NONE cterm=NONE                  ctermbg=252
highlight PmenuSel       term=NONE cterm=NONE      ctermfg=255 ctermbg=243
highlight PmenuThumb     term=NONE cterm=NONE      ctermfg=243
highlight PreProc        term=NONE cterm=NONE      ctermfg=150
highlight Search         term=NONE cterm=NONE      ctermfg=0   ctermbg=149
highlight SignColumn     term=NONE cterm=NONE      ctermfg=248
highlight Special        term=NONE cterm=NONE      ctermfg=174
highlight SpecialKey     term=NONE cterm=NONE      ctermfg=237
highlight SpellBad       term=NONE cterm=underline ctermfg=160 ctermbg=bg
highlight SpellCap       term=NONE cterm=underline ctermfg=189 ctermbg=bg
highlight SpellLocal     term=NONE cterm=underline ctermfg=98  ctermbg=bg
highlight SpellRare      term=NONE cterm=underline ctermfg=168 ctermbg=bg
highlight Statement      term=NONE cterm=NONE      ctermfg=110
highlight StatusLine     term=NONE cterm=NONE      ctermfg=255 ctermbg=0
highlight StatusLineNC   term=NONE cterm=NONE      ctermfg=15  ctermbg=235
highlight TabLine        term=NONE cterm=NONE      ctermfg=fg  ctermbg=242
highlight TabLineFill    term=NONE cterm=NONE      ctermfg=fg  ctermbg=237
highlight Title          term=NONE cterm=NONE      ctermfg=225
highlight Todo           term=NONE cterm=NONE      ctermfg=0   ctermbg=184
highlight Type           term=NONE cterm=NONE      ctermfg=146
highlight Underlined     term=NONE cterm=underline ctermfg=39
highlight VertSplit      term=NONE cterm=NONE      ctermfg=237 ctermbg=237
highlight Visual         term=NONE cterm=NONE      ctermfg=255 ctermbg=96
highlight VisualNOS      term=NONE cterm=NONE      ctermfg=255 ctermbg=60
highlight WildMenu       term=NONE cterm=bold      ctermfg=0   ctermbg=150

highlight diffAdded    ctermfg=150
highlight diffRemoved  ctermfg=174
highlight diffAdd      ctermfg=bg        ctermbg=151
highlight diffDelete   ctermfg=bg        ctermbg=246
highlight diffChange   ctermfg=bg        ctermbg=181
highlight diffText     ctermfg=bg        ctermbg=174
