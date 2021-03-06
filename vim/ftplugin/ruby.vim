if exists("b:ruby_ftplugin")
  finish
endif
let b:ruby_ftplugin = 1

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

map <silent> ]] /\m\<def\><cr>
map <silent> [[ ?\m\<def\><cr>

if !exists("b:ruby_spring")
  let b:ruby_spring = 0
  if filereadable("Gemfile")
    if !empty(filter(readfile("Gemfile"), "v:val =~# 'spring-commands-rspec'"))
      let b:ruby_spring = 1
    endif
  endif
endif

iabbrev bp binding.pry

command! -buffer -nargs=* Reek compiler reek | make <args>
command! -buffer -nargs=* Rubocop compiler rubocop | make <args>
command! -buffer Pronto compiler pronto | make
command! -buffer RSpec compiler rspec | execute "make :".line(".")
command! -buffer -range HashToJson s/=>/:/e | s/\<nil\>/null/e | .!json_pp

nnoremap <buffer> <expr> <silent> <leader>r RubyTest()

function! RubyTest()
  let line = line(".")
  let filename = expand("%")
  let spring = b:ruby_spring ? "spring " : ""
  let @*="bundle exec ".spring."rspec ".filename.":".line
  echo "Test copied: ".@*
endfunction

command! -buffer CreateSpecFile execute 'split | edit '.substitute(substitute(expand("%"), "app\/", "spec/", ""), "\.rb$", "_spec.rb", "")
