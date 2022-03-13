" https://jonasjacek.github.io/colors/

highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'basic'

let s:black   = ['#000000', 0]
let s:white   = ['#ffffff', 15]

let s:red     = ['#aa5555', 160]
let s:green   = ['#55aa55', 82]
let s:yellow  = ['#aaaa55', 184]
let s:orange  = ['DarkOrange', 166]
let s:blue    = ['#5555aa', 25]
let s:purple  = ['#aa55aa', 135]
let s:cyan    = ['#55aaaa', 45]
let s:gray    = ['#aaaaaa', 245]

let s:red_alarm = ['#ff0000', 1]

if &background == 'light'
  let s:red_lc    = ['#bb1111', 9]
  let s:green_lc  = ['#11bb11', 10]
  let s:yellow_lc = ['#cccc11', 11]
  let s:blue_lc   = ['#1111bb', 12]
  let s:purple_lc = ['#bb11bb', 13]
  let s:cyan_lc   = ['#11bbbb', 14]
  let s:gray_lc   = ['#e0e0e0', 250]

  let s:red_hc    = ['#aa0000', 1]
  let s:green_hc  = ['#00aa00', 2]
  let s:yellow_hc = ['#aaaa00', 3]
  let s:blue_hc   = ['#0000aa', 4]
  let s:purple_hc = ['#aa00aa', 5]
  let s:cyan_hc   = ['#00aaaa', 6]
  let s:orange_hc = ['#db8d18', 240]
  let s:gray_hc   = ['#606060', 240]

  let s:default_fg = s:black
  let s:default_bg = ['#ebebe6', 'NONE']
else
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
  let s:default_bg = [ '#202020', 'NONE']
end

let s:default_lst2 = []
let s:default_str2 = ''

function! s:hi(...)
  let group = a:1
  let fg    = get(a:, 2, s:default_fg)
  let bg    = get(a:, 3, s:default_bg)
  let attr  = get(a:, 4, s:default_str2)

  let cmd = ['hi', group]

  if fg != s:default_lst2
    call add(cmd, 'guifg='.fg[0])
    call add(cmd, 'ctermfg='.fg[1])
  endif

  if bg != s:default_lst2
    call add(cmd, 'guibg='.bg[0])
    call add(cmd, 'ctermbg='.bg[1])
  endif

  if attr != s:default_str2
    call add(cmd, 'gui='.attr)
    call add(cmd, 'cterm='.attr)
  endif

  exec join(cmd, ' ')
endfunction

" Vim interface
call s:hi('ColorColumn', s:default_fg, s:gray_lc)
call s:hi('Cursor', s:black, s:orange)
call s:hi('CursorColumn', s:default_lst2, s:gray_lc)
call s:hi('CursorLine', s:default_lst2, s:gray_lc)
call s:hi('CursorLineNr')
call s:hi('Error', s:default_bg, s:red)
call s:hi('ErrorMsg', s:default_bg, s:red)
call s:hi('IncSearch', s:default_fg, s:yellow_lc)
call s:hi('Normal')
call s:hi('Search', s:black, s:yellow_lc)
call s:hi('StatusLine', s:default_fg, s:default_bg)
call s:hi('StatusLineNC', s:default_fg, s:default_bg)
call s:hi('StatusLineTerm', s:default_bg, s:default_fg)
call s:hi('StatusLineTermNC', s:default_bg, s:default_fg)
call s:hi('TabLine', s:default_bg, s:default_fg, 'reverse')
call s:hi('TabLineFill', s:default_bg, s:default_fg, 'reverse')
call s:hi('TabLineSel', s:default_fg, s:default_bg, 'reverse,bold')
call s:hi('VertSplit', s:default_bg, s:gray_hc)
call s:hi('Visual', s:default_lst2, s:gray_lc)

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
call s:hi('Comment', s:red_alarm)
call s:hi('Constant', s:red_hc)
call s:hi('Identifier', s:blue_hc)
call s:hi('Statement', s:purple_hc)
call s:hi('PreProc', s:purple_hc)
call s:hi('Type', s:blue_hc)
call s:hi('Special', s:purple_hc)

call s:hi('MatchParen', s:black, s:yellow_hc)

" Diffs
call s:hi('DiffAdd', s:green_lc)
call s:hi('DiffChange', s:default_fg)
call s:hi('DiffDelete', s:red_lc)
call s:hi('DiffText', s:cyan_lc)
call s:hi('diffAdded', s:green_lc)
call s:hi('diffFile', s:default_fg, s:gray_lc)
call s:hi('diffIndexLine', s:default_fg, s:gray_lc)
call s:hi('diffLine', s:default_fg, s:gray_lc)
call s:hi('diffNewFile', s:default_fg, s:gray_lc)
call s:hi('diffRemoved', s:red_lc)
call s:hi('diffSubname', s:default_fg, s:gray_lc)

" CoC
call s:hi('CocErrorFloat', s:red_hc, s:gray_lc)
call s:hi('CocErrorSign', s:red_lc, s:gray_lc)

call s:hi('CocInfoFloat', s:green_hc, s:gray_lc)
call s:hi('CocInfoSign', s:orange_hc, s:gray_lc)

call s:hi('CocWarningFloat', s:yellow_hc, s:gray_lc)
call s:hi('CocWarningSign', s:yellow_hc, s:gray_lc)

call s:hi('LspDiagnosticsDefaultInformation', s:yellow_hc, s:gray_lc)
call s:hi('LspDiagnosticsDefaultWarning', s:orange_hc, s:gray_lc)
call s:hi('LspDiagnosticsDefaultError', s:red_hc, s:gray_lc)
call s:hi('LspDiagnosticsDefaultHint', s:gray_hc, s:gray_lc)

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
