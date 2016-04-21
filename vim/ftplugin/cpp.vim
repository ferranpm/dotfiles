noremap <leader>m; :call cpp#ToSource()<cr>
noremap <leader>m: :call cpp#ToHeader()<cr>

set indentexpr=cpp#QtCppIndent()
set omnifunc=omni#cpp#complete#Main

" Generate more tags using this:
" ctags -R --sort=yes --c++-kinds=+p --fields=+iaS --extra=+q --language-force=C++ -f output /path/to/source
setlocal tags+=~/.vim/tags/cpp/cpp
setlocal tags+=~/.vim/tags/cpp/qt5
