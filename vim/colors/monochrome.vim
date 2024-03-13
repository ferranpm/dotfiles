" https://jonasjacek.github.io/colors/

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monochrome'

let s:none = ['NONE', 'NONE']

if &background == 'dark'
  let s:white           = ['Gray90',  15]
  let s:black           = ['Gray10',   0]

  let s:higher_contrast = s:white
  let s:high_contrast   = ['Gray74', 250]
  let s:medium_contrast = ['Gray35', 240]
  let s:low_contrast    = ['Gray15', 235]
  let s:lower_contrast  = s:black

  let s:blue   = ['SlateGray4', 67]
  let s:yellow = ['Yellow', 226]
  let s:red    = ['IndianRed', 9]
  let s:green  = ['DarkGreen', 28]
  let s:orange = ['DarkOrange', 166]

  let s:diff_delete = s:red
  let s:diff_add  = s:green

  let s:default_fg = ['LightGray', 255]
  let s:default_bg = ['NONE', 'NONE']
else
  let s:white           = ['Gray90', 255]
  let s:black           = ['Gray0',  232]

  let s:higher_contrast = s:black
  let s:high_contrast   = ['Gray20', 233]
  let s:medium_contrast = ['Gray60', 247]
  let s:low_contrast    = ['Gray85', 253]
  let s:lower_contrast  = s:white

  let s:blue   = ['SlateGray4',  67]
  let s:yellow = ['Yellow3',    226]

  let s:red    = ['IndianRed2',        160]
  let s:green  = ['Green4',      28]
  let s:orange = ['Orange',     166]

  let s:diff_delete = ['#ffdce0',   160]
  let s:diff_add  = ['#cdffd8',      28]

  let s:default_fg = ['NONE',  'NONE']
  let s:default_bg = ['NONE', 'NONE']
endif

let s:default_lst = []
let s:default_str = 'NONE'

function! s:hi(...)
  let group = a:1
  let fg    = get(a:, 2, s:default_fg)
  let bg    = get(a:, 3, s:default_bg)
  let attr  = get(a:, 4, s:default_str)

  let cmd = ['hi', group]

  if fg != s:default_lst
    call add(cmd, 'guifg='.fg[0])
    call add(cmd, 'ctermfg='.fg[1])
  endif

  if bg != s:default_lst
    call add(cmd, 'guibg='.bg[0])
    call add(cmd, 'ctermbg='.bg[1])
  endif

  if attr != s:default_str
    call add(cmd, 'gui='.attr)
    call add(cmd, 'cterm='.attr)
  endif

  exec join(cmd, ' ')
endfunction

" Vim interface
call s:hi('ColorColumn', s:default_fg, s:low_contrast)
call s:hi('Cursor', s:black, s:orange)
call s:hi('CursorColumn', s:default_lst, s:low_contrast)
call s:hi('CursorLine', s:default_lst, s:low_contrast)
call s:hi('CursorLineNr', s:default_fg, s:default_bg, 'bold')
call s:hi('ErrorMsg', s:default_fg, s:red)
call s:hi('WarningMsg', s:default_fg, s:orange)
call s:hi('IncSearch')
call s:hi('Normal')
call s:hi('Search', s:white, s:blue)
call s:hi('StatusLine',       s:higher_contrast, s:lower_contrast, 'reverse,bold')
call s:hi('StatusLineNC',     s:high_contrast, s:medium_contrast, 'reverse')
call s:hi('StatusLineTerm',   s:higher_contrast, s:low_contrast, 'reverse,bold')
call s:hi('StatusLineTermNC', s:high_contrast, s:medium_contrast, 'reverse')
call s:hi('TabLine',     s:high_contrast, s:low_contrast, 'reverse')
call s:hi('TabLineFill', s:high_contrast, s:low_contrast)
call s:hi('TabLineSel',  s:high_contrast, s:low_contrast)
call s:hi('VertSplit', s:default_bg, s:default_fg)
call s:hi('WildMenu', s:white, s:medium_contrast)
call s:hi('WinSeparator', s:default_fg, s:default_bg)
call s:hi('Visual', s:white, s:blue)

" Tildes at the bottom of a buffer, etc
call s:hi('NonText')

" Folding
call s:hi('FoldColumn')
call s:hi('Folded', s:medium_contrast, s:low_contrast)

" Line numbers gutter
call s:hi('LineNr', s:medium_contrast)

" Small arrow used for tabs
call s:hi('SpecialKey', s:blue, s:default_bg, 'bold')

" File browsers
call s:hi('Directory', s:default_fg, s:default_bg, 'bold')

" Popup menu
call s:hi('Pmenu',    s:higher_contrast, s:low_contrast)
call s:hi('PmenuSel', s:lower_contrast,  s:medium_contrast)

" Notes
call s:hi('Todo', s:black, s:yellow, 'bold')

" Signs
call s:hi('SignColumn', s:low_contrast, s:low_contrast)

call s:hi('Title', s:default_fg, s:default_bg, 'bold')

" Programming languages
call s:hi('Comment', s:red)
call s:hi('Constant', s:blue)
call s:hi('Identifier')
call s:hi('Statement', s:default_fg, s:default_bg, 'bold')
call s:hi('PreProc', s:default_fg, s:default_bg, 'bold')
call s:hi('Special')
call s:hi('Type')

" Diffs
call s:hi('DiffAdd', s:default_fg, s:diff_add)
call s:hi('DiffChange', s:default_fg, s:low_contrast)
call s:hi('DiffDelete', s:default_fg, s:diff_delete)
call s:hi('DiffText', s:default_fg, s:diff_delete)
call s:hi('diffAdded', s:default_fg, s:diff_add)
call s:hi('diffFile', s:medium_contrast)
call s:hi('diffIndexLine', s:medium_contrast)
call s:hi('diffLine', s:medium_contrast)
call s:hi('diffNewFile', s:medium_contrast)
call s:hi('diffRemoved', s:default_fg, s:diff_delete)
call s:hi('diffSubname', s:medium_contrast)

call s:hi('DiagnosticUnderlineError', [ 'Red', 1 ])
call s:hi('DiagnosticUnderlineWarn', [ 'Orange', 3 ])
call s:hi('DiagnosticUnderlineInfo', [ 'Orange', 3 ])
call s:hi('DiagnosticUnderlineHint', [ 'Orange', 3 ])

" Terminal
let g:terminal_ansi_colors = [
      \ s:black[0],
      \ s:red[0],
      \ s:green[0],
      \ s:yellow[0],
      \ s:blue[0],
      \ s:red[0],
      \ s:green[0],
      \ s:medium_contrast[0],
      \ s:medium_contrast[0],
      \ s:red[0],
      \ s:green[0],
      \ s:yellow[0],
      \ s:blue[0],
      \ s:red[0],
      \ s:blue[0],
      \ s:white[0],
      \ ]

let g:terminal_color_0 = s:black[0]
let g:terminal_color_1 = s:red[0]
let g:terminal_color_2 = s:green[0]
let g:terminal_color_3 = s:yellow[0]
let g:terminal_color_4 = s:blue[0]
let g:terminal_color_5 = s:red[0]
let g:terminal_color_6 = s:green[0]
let g:terminal_color_7 = s:medium_contrast[0]
let g:terminal_color_8 = s:medium_contrast[0]
let g:terminal_color_9 = s:red[0]
let g:terminal_color_10 = s:green[0]
let g:terminal_color_11 = s:yellow[0]
let g:terminal_color_12 = s:blue[0]
let g:terminal_color_13 = s:red[0]
let g:terminal_color_14 = s:blue[0]
let g:terminal_color_15 = s:white[0]

call s:hi('CopilotSuggestion', s:medium_contrast)
