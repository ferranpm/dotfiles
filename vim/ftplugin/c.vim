command -buffer -range ToSource <line1>,<line2>call c#to_source()
command -buffer -range ToHeader <line1>,<line2>call c#to_header()

" Text object for 'arround function'
vmap <buffer> <silent> af <esc>][v%?^\w\+<cr>
onoremap <buffer> <silent> af :normal Vaf<CR>
