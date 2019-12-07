highlight clear

if exists('syntax_on')
  syntax reset
endif

let g:colors_name = 'basic'

let s:black   = ['#000000', 0]
let s:white   = ['#ffffff', 15]

let s:red     = ['#990000', 160]
let s:green   = ['#009900', 82]
let s:yellow  = ['#999900', 184]
let s:blue    = ['#000099', 25]
let s:purple  = ['#990099', 135]
let s:cyan    = ['#009999', 45]
let s:gray    = ['#999999', 245]

if &background == 'light'
  let s:red_lc    = ['#ee0000', 9]
  let s:green_lc  = ['#00ee00', 10]
  let s:yellow_lc = ['#eeee00', 11]
  let s:blue_lc   = ['#0000ee', 12]
  let s:purple_lc = ['#ee00ee', 13]
  let s:cyan_lc   = ['#00eeee', 14]
  let s:gray_lc   = ['#eeeeee', 15]

  let s:red_hc    = ['#770000', 1]
  let s:green_hc  = ['#007700', 2]
  let s:yellow_hc = ['#777700', 3]
  let s:blue_hc   = ['#000077', 4]
  let s:purple_hc = ['#770077', 5]
  let s:cyan_hc   = ['#770077', 6]
  let s:gray_hc   = ['#777777', 240]

  let s:default_fg = s:black
  let s:default_bg = ['#ffffff', 'NONE']
else
  let s:red_lc    = ['#550000', 9]
  let s:green_lc  = ['#005500', 10]
  let s:yellow_lc = ['#555500', 11]
  let s:blue_lc   = ['#000055', 12]
  let s:purple_lc = ['#550055', 13]
  let s:cyan_lc   = ['#550055', 14]
  let s:gray_lc   = ['#555555', 235]

  let s:red_hc    = ['#dd9999', 1]
  let s:green_hc  = ['#99dd99', 2]
  let s:yellow_hc = ['#dddd99', 3]
  let s:blue_hc   = ['#9999dd', 4]
  let s:purple_hc = ['#dd99dd', 5]
  let s:cyan_hc   = ['#99dddd', 6]
  let s:gray_hc   = ['#cccccc', 250]

  let s:default_fg = ['#eeeeee', 7]
  let s:default_bg = ['#20201e', 'NONE']
end

let s:default_lst2 = ['NONE', 'NONE']
let s:default_str2 = ''

function! s:hi(...)
  let group = a:1
  let fg    = get(a:, 2, s:default_fg)
  let bg    = get(a:, 3, s:default_bg)
  let attr  = get(a:, 4, s:default_str2)

  let cmd = ['hi', group]

    call add(cmd, 'guifg='.fg[0])
    call add(cmd, 'ctermfg='.fg[1])

    call add(cmd, 'guibg='.bg[0])
    call add(cmd, 'ctermbg='.bg[1])

  if attr != s:default_str2
    call add(cmd, 'gui='.attr)
    call add(cmd, 'cterm='.attr)
  endif

  exec join(cmd, ' ')
endfunction

" Vim interface
call s:hi('ColorColumn', s:default_fg, s:gray_lc)
call s:hi('CursorColumn', s:default_lst2, s:gray_lc)
call s:hi('CursorLine', s:default_lst2, s:gray_lc)
call s:hi('CursorLineNr')
call s:hi('Error', s:default_bg, s:red_lc)
call s:hi('ErrorMsg', s:default_bg, s:red_lc)
call s:hi('IncSearch')
call s:hi('Normal')
call s:hi('Search', s:default_lst2, s:yellow_lc)
call s:hi('StatusLine', s:default_fg, s:default_bg)
call s:hi('StatusLineNC', s:default_fg, s:default_bg)
call s:hi('StatusLineTerm', s:default_bg, s:default_fg)
call s:hi('StatusLineTermNC', s:default_bg, s:default_fg)
call s:hi('TabLine', s:default_lst2, s:default_lst2, 'reverse')
call s:hi('TabLineFill', s:default_lst2, s:default_lst2, 'reverse')
call s:hi('TabLineSel', s:default_lst2, s:gray_lc, 'bold')
call s:hi('Visual', s:default_lst2, s:gray_lc)

" Tildes at the bottom of a buffer, etc.
call s:hi('NonText', s:blue_hc)

" Folding.
call s:hi('FoldColumn', s:blue_hc, s:default_bg)
call s:hi('Folded', s:blue_lc, s:gray_lc)

" Line numbers gutter.
call s:hi('LineNr', s:gray_hc)

" Small arrow used for tabs.
call s:hi('SpecialKey', s:blue_hc)

" File browsers.
call s:hi('Directory', s:blue_hc)

" Popup menu.
call s:hi('Pmenu', s:gray_hc, s:gray_lc)
call s:hi('PmenuSbar', s:black, s:gray)
call s:hi('PmenuSel', s:gray_lc, s:gray_hc)
call s:hi('PmenuThumb', s:black, s:black)

" Notes.
call s:hi('Todo', s:black, s:yellow_lc)

" Signs.
call s:hi('SignColumn')

" Programming languages
call s:hi('Comment', s:gray_hc)
call s:hi('Constant', s:red_hc)
call s:hi('Identifier', s:blue_hc)
call s:hi('Statement', s:purple_hc)
call s:hi('PreProc', s:purple_hc)
call s:hi('Type', s:yellow_hc)
call s:hi('Special')

call s:hi('MatchParen', s:default_fg, s:yellow)

" Diffs
call s:hi('DiffAdd', s:default_fg, s:green_lc)
call s:hi('DiffChange', s:default_fg, s:gray_lc)
call s:hi('DiffDelete', s:default_fg, s:red_lc)
call s:hi('DiffText', s:default_fg, s:cyan_lc)
call s:hi('diffAdded', s:default_fg, s:green_lc)
call s:hi('diffFile', s:default_fg, s:gray_lc)
call s:hi('diffIndexLine', s:default_fg, s:gray_lc)
call s:hi('diffLine', s:default_fg, s:gray_lc)
call s:hi('diffNewFile', s:default_fg, s:gray_lc)
call s:hi('diffRemoved', s:default_fg, s:red_lc)
call s:hi('diffSubname', s:default_fg, s:gray_lc)

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
