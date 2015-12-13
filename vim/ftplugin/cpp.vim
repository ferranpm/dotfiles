noremap <leader>m; :call cpp#to_source()<cr>
noremap <leader>m: :call cpp#to_header()<cr>

set indentexpr=cpp#qt_cpp_indent()
set omnifunc=omni#cpp#complete#Main

" Generate more tags using this:
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f output /path/to/source
setlocal tags+=~/.vim/tags/cpp/cpp
setlocal tags+=~/.vim/tags/cpp/qt5
