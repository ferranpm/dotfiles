if exists('g:auto_pairs_loaded') || &cp
  finish
end
let g:auto_pairs_loaded = 1

if !exists('g:pairs')
    let g:pairs = {
                \ '[': ']',
                \ '{': '}',
                \ '(': ')',
                \ '"': '"',
                \ "'": "'",
                \ '`': '`'
                \ }
endif

for key in extend(keys(g:pairs), values(g:pairs))
    let escaped_key = substitute(key, "'", "''", 'g')
    execute 'inoremap <silent>'.key." <C-R>=autopairs#insert('".escaped_key."')<CR>"
endfor
inoremap <silent> <cr> <C-R>=autopairs#insert('cr')<cr>
inoremap <silent> <space> <C-R>=autopairs#insert(' ')<cr>
inoremap <silent> <bs> <C-R>=autopairs#insert('bs')<cr>
