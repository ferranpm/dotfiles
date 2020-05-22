let g:ale_disable_lsp = v:false

set omnifunc=ale#completion#OmniFunc
inoremap <expr> <c-l> pumvisible() ? "\<c-n>" : "\<c-x>\<c-o>"

nmap <silent> gd <Plug>(ale_go_to_definition)
nmap <silent> gr <Plug>(ale_find_references)

let g:ale_linters = get(g:, "ale_fixers", {})
let g:ale_linters["ruby"] = [ "solargraph", "rubocop" ]

let g:ale_fixers = get(g:, "ale_fixers", {})
let g:ale_fixers["ruby"] = [ "rubocop" ]

noremap <silent> [d :ALEPrevious<cr>
noremap <silent> ]d :ALENext<cr>
noremap <silent> gd :ALEGoToDefinition<cr>
