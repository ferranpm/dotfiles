noremap <leader>m; :call cpp#to_source()<cr>
noremap <leader>m: :call cpp#to_header()<cr>

set indentexpr=cpp#qt_cpp_indent()
set omnifunc=omni#cpp#complete#main
