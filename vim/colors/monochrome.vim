" https://jonasjacek.github.io/colors/
"
" Vim color scheme
"
" Name:       monochrome.vim
" Maintainer: Xavier Noria <fxn@hashref.com>
" License:    MIT

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'monochrome'

let s:red_hc = ['Red', 1]

if &background == 'dark'
  let s:white           = ['Gray90',  15]
  let s:black           = ['Gray10',   0]

  let s:high_contrast   = ['Gray74', 250]
  let s:medium_contrast = ['Gray35', 240]
  let s:low_contrast    = ['Gray15', 235]

  let s:blue   = ['SlateGray4', 67]
  let s:yellow = ['Yellow', 226]
  let s:red    = ['DarkRed', 9]
  let s:green  = ['DarkGreen', 28]
  let s:orange = ['DarkOrange', 166]

  let s:diff_delete = s:red
  let s:diff_add  = s:green

  let s:default_fg = ['LightGray', 255]
  let s:default_bg = ['gray13', 'black']
else
  let s:white           = ['Gray93', 255]
  let s:black           = ['Gray3',  232]
  let s:high_contrast   = ['Gray7',  233]
  let s:medium_contrast = ['Gray62', 247]
  let s:low_contrast    = ['Gray85', 253]

  let s:blue   = ['SlateGray4',  67]
  let s:yellow = ['gold3',      226]
  let s:red    = ['Red',        160]
  let s:green  = ['Green4',      28]
  let s:orange = ['Orange',     166]

  let s:diff_delete = ['#ffdce0',   160]
  let s:diff_add  = ['#cdffd8',      28]

  let s:default_fg = ['Gray3',  'NONE']
  let s:default_bg = ['#ebebe6', 'NONE']
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
call s:hi('Normal')
call s:hi('Search', s:white, s:blue)
call s:hi('StatusLine', s:high_contrast, s:default_bg, 'reverse,bold')
call s:hi('StatusLineNC', s:high_contrast, s:default_bg, 'reverse')
call s:hi('StatusLineTerm', s:default_bg, s:high_contrast, 'bold')
call s:hi('StatusLineTermNC', s:default_bg, s:high_contrast)
call s:hi('TabLine')
call s:hi('TabLineFill', s:default_bg, s:default_fg)
call s:hi('TabLineSel', s:default_bg, s:high_contrast)
call s:hi('VertSplit', s:default_bg, s:default_fg)
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
call s:hi('Pmenu', s:high_contrast, s:low_contrast)
call s:hi('PmenuSel', s:low_contrast, s:medium_contrast)

" Notes
call s:hi('Todo', s:black, s:yellow, 'bold')

" Signs
call s:hi('SignColumn', s:low_contrast, s:low_contrast)

call s:hi('Title', s:default_fg, s:default_bg, 'bold')

" Programming languages
call s:hi('Comment', s:red_hc)
call s:hi('Constant', s:blue, s:default_bg, 'bold')
call s:hi('Identifier')
call s:hi('Statement', s:high_contrast)
call s:hi('PreProc', s:high_contrast, s:default_bg, 'bold')
call s:hi('Type', s:high_contrast)
call s:hi('Special')

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

call s:hi('LspDiagnosticsDefaultInformation', s:yellow, s:low_contrast)
call s:hi('LspDiagnosticsDefaultWarning', s:orange, s:low_contrast)
call s:hi('LspDiagnosticsDefaultError', s:red, s:low_contrast)
call s:hi('LspDiagnosticsDefaultHint', s:high_contrast, s:low_contrast)

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

call s:hi('DiagnosticError', [ 'Red'      , 1 ], s:low_contrast)
call s:hi('DiagnosticWarn',  [ 'Orange'   , 3 ], s:low_contrast)
call s:hi('DiagnosticInfo',  [ 'LightBlue', 4 ], s:low_contrast)
call s:hi('DiagnosticHint',  [ 'LightGrey', 7 ], s:low_contrast)

call s:hi('DiagnosticVirtualTextError', [ 'Red'      , 1 ])
call s:hi('DiagnosticVirtualTextWarn',  [ 'Orange'   , 3 ])
call s:hi('DiagnosticVirtualTextInfo',  [ 'LightBlue', 4 ])
call s:hi('DiagnosticVirtualTextHint',  [ 'LightGrey', 7 ])

