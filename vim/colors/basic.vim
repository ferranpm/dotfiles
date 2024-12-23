" https://jonasjacek.github.io/colors/

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'basic'

let s:red     = ['#aa5555', 160]
let s:green   = ['#55aa55', 82]
let s:yellow  = ['#aaaa55', 184]
let s:orange  = ['DarkOrange', 166]
let s:blue    = ['#5555aa', 25]
let s:purple  = ['#aa55aa', 135]
let s:cyan    = ['#55aaaa', 45]
let s:gray    = ['#aaaaaa', 245]

let s:none = ['NONE', 'NONE']

if &background == 'light'
  let s:black   = ['#000000', 0]
  let s:white   = ['#ffffff', 15]

  let s:red_lc    = ['#bb5555', 9]
  let s:green_lc  = ['#55bb55', 10]
  let s:yellow_lc = ['#cccc55', 11]
  let s:blue_lc   = ['#5555bb', 12]
  let s:purple_lc = ['#bb55bb', 13]
  let s:cyan_lc   = ['#55bbbb', 14]
  let s:gray_lc   = ['#e0e0e0', 250]

  let s:red_hc    = ['#bb0000', 1]
  let s:green_hc  = ['#008800', 2]
  let s:yellow_hc = ['#aaaa00', 3]
  let s:blue_hc   = ['#0000aa', 4]
  let s:purple_hc = ['#aa00aa', 5]
  let s:cyan_hc   = ['#00dddd', 6]
  let s:orange_hc = ['#db8d18', 240]
  let s:gray_hc   = ['#606060', 240]

  let s:default_fg = s:black
  let s:default_bg = ['NONE', 'NONE']
else
  let s:black   = ['#000000', 0]
  let s:white   = ['#ffffff', 15]

  let s:red_lc    = ['#bf4b5c', 9]
  let s:green_lc  = ['#7a8a48', 10]
  let s:yellow_lc = ['#917b17', 11]
  let s:blue_lc   = ['#b3deef', 12]
  let s:purple_lc = ['#d3b987', 13]
  let s:cyan_lc   = ['#66b6d9', 14]
  let s:gray_lc   = ['#444444', 236]

  let s:red_hc    = ['#a52946', 1]
  let s:green_hc  = ['#91b837', 2]
  let s:yellow_hc = ['#fff34b', 3]
  let s:blue_hc   = ['#7396bf', 4]
  let s:purple_hc = ['#96679e', 5]
  let s:cyan_hc   = ['#73cef4', 6]
  let s:orange_hc = ['#d49d31', 240]
  let s:gray_hc   = ['#aaaaaa', 240]

  let s:default_fg = [ '#c5c5c5', 'NONE']
  let s:default_bg = [ 'NONE', 'NONE']
end

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
call s:hi('ColorColumn', s:default_fg, s:gray_lc)
call s:hi('Cursor', s:black, s:orange)
call s:hi('CursorColumn', s:default_lst, s:gray_lc)
call s:hi('CursorLine', s:default_lst, s:gray_lc)
call s:hi('CursorLineNr')
call s:hi('ErrorMsg', s:white, s:red_lc)
call s:hi('WarningMsg', s:default_fg, s:orange)
call s:hi('Normal', s:none, s:none)
call s:hi('StatusLine', s:default_fg, s:default_bg, 'reverse,bold')
call s:hi('StatusLineNC', s:gray_hc, s:default_bg, 'reverse')
call s:hi('StatusLineTerm', s:default_bg, s:default_fg, 'reverse')
call s:hi('StatusLineTermNC', s:default_bg, s:default_fg, 'reverse')
call s:hi('TabLine', s:default_bg, s:default_fg, 'reverse')
call s:hi('TabLineFill', s:default_bg, s:default_fg, 'reverse')
call s:hi('TabLineSel', s:default_fg, s:default_bg, 'reverse,bold')
call s:hi('VertSplit', s:default_fg, s:default_bg)
call s:hi('Visual', s:default_fg, s:gray_lc)

" Search
call s:hi('CurSearch', s:white, s:yellow_hc)
call s:hi('IncSearch', s:default_fg, s:orange_hc)
call s:hi('Search', s:default_fg, s:yellow_lc)

" Tildes at the bottom of a buffer, etc.
call s:hi('NonText', s:blue_hc)

" Folding.
call s:hi('FoldColumn', s:blue_hc, s:default_bg)
call s:hi('Folded', s:blue_hc, s:gray_lc)

" Line numbers gutter.
call s:hi('LineNr', s:gray_hc)

" Small arrow used for tabs.
call s:hi('SpecialKey', s:blue_hc)

" File browsers.
call s:hi('Directory', s:blue_hc)

" Popup menu.
call s:hi('Pmenu', s:default_fg, s:gray_lc)
call s:hi('PmenuSbar', s:default_fg, s:gray)
call s:hi('PmenuSel', s:black, s:gray)
call s:hi('PmenuThumb')

" Notes.
call s:hi('Todo', s:black, s:yellow_lc)

" Signs.
call s:hi('SignColumn', s:gray_hc, s:gray_lc)

" Programming languages
call s:hi('Comment', s:red_hc)
call s:hi('Constant', s:red_hc)
call s:hi('String', s:red_lc)
call s:hi('Identifier', s:blue_hc)
call s:hi('Statement', s:purple_hc)
call s:hi('Operator')
call s:hi('PreProc', s:purple_hc)
call s:hi('Type', s:blue_hc)
call s:hi('Special', s:purple_hc)

call s:hi('MatchParen', s:black, s:yellow_hc)

call s:hi('Added', s:green_hc)
call s:hi('Changed', s:blue_hc)
call s:hi('Removed', s:red_hc)

" Diffs
call s:hi('DiffAdd', s:green_hc)
call s:hi('DiffChange', s:default_fg)
call s:hi('DiffDelete', s:red_hc)
call s:hi('DiffText', s:default_fg, s:cyan_hc)
call s:hi('diffAdded', s:green_hc)
call s:hi('diffFile', s:default_fg, s:gray_lc)
call s:hi('diffIndexLine', s:default_fg, s:gray_lc)
call s:hi('diffLine', s:default_fg, s:gray_lc)
call s:hi('diffNewFile', s:default_fg, s:gray_lc)
call s:hi('diffRemoved', s:red_lc)
call s:hi('diffSubname', s:default_fg, s:gray_lc)

call s:hi('LspDiagnosticsDefaultInformation', s:yellow_hc, s:gray_lc)
call s:hi('LspDiagnosticsDefaultWarning', s:orange_hc, s:gray_lc)
call s:hi('LspDiagnosticsDefaultError', s:red_hc, s:gray_lc)
call s:hi('LspDiagnosticsDefaultHint', s:gray_hc, s:gray_lc)

call s:hi('AvanteConfigIncomming', s:default_fg, s:gray_lc)

" Terminal
let g:terminal_ansi_colors = [
      \ s:black[0],
      \ s:red_hc[0],
      \ s:green_hc[0],
      \ s:yellow_hc[0],
      \ s:blue_hc[0],
      \ s:red[0],
      \ s:green[0],
      \ s:gray_lc[0],
      \ s:gray_hc[0],
      \ s:red[0],
      \ s:green[0],
      \ s:yellow[0],
      \ s:blue[0],
      \ s:red_lc[0],
      \ s:blue_lc[0],
      \ s:white[0],
      \ ]

let g:terminal_color_0 = s:black[0]
let g:terminal_color_1 = s:red_hc[0]
let g:terminal_color_2 = s:green_hc[0]
let g:terminal_color_3 = s:yellow_hc[0]
let g:terminal_color_4 = s:blue_hc[0]
let g:terminal_color_5 = s:red[0]
let g:terminal_color_6 = s:green[0]
let g:terminal_color_7 = s:gray_lc[0]
let g:terminal_color_8 = s:gray_hc[0]
let g:terminal_color_9 = s:red[0]
let g:terminal_color_10 = s:green[0]
let g:terminal_color_11 = s:yellow[0]
let g:terminal_color_12 = s:blue[0]
let g:terminal_color_13 = s:red_lc[0]
let g:terminal_color_14 = s:blue_lc[0]
let g:terminal_color_15 = s:white[0]
