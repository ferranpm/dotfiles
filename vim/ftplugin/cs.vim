setlocal omnifunc=OmniSharp#Complete

nnoremap <leader>f :OmniSharpFindType<cr>
nnoremap <leader>y :OmniSharpFindSymbol<cr>
nnoremap <leader>u :OmniSharpFindUsages<cr>
nnoremap <leader>g :OmniSharpGotoDefinition<cr>
nnoremap <F5>      :OmniSharpBuildAsync<cr>

set foldmethod=marker
set foldlevel=2

command! InvokeIfRequired s/\([a-zA-Z0-9]*\)\(\..*\)/Utils.InvokeIfRequired(\1,()=>{\1\2});
