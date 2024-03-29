if exists("b:ruby_ftplugin")
  finish
endif
let b:ruby_ftplugin = 1

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

map <buffer><silent> ]] /\m\<def\><cr>
map <buffer><silent> [[ ?\m\<def\><cr>

iabbrev bp binding.pry

command! -buffer -nargs=* -complete=file Reek compiler reek | make <args>
command! -buffer -nargs=* -complete=file Rubocop compiler rubocop | make <args>
command! -buffer Pronto compiler pronto | make
command! -buffer RSpec compiler rspec | execute "make :".line(".")
command! -buffer -range HashToJson s/=>/:/e | s/\<nil\>/null/e | .!json_pp

nnoremap <buffer> <silent> <leader>t :update \| call RubyTest()<cr>

function! RubyTest()
  let line = line(".")
  let filename = expand("%")

  if match(filename, "_spec.rb$") > 0
    let @*="bundle exec rspec ".filename.":".line
  else
    let @*="./bin/test ".filename.":".line
  endif

  echo "Test copied: ".@*
endfunction

command! -buffer CreateSpecFile execute 'split | edit '.substitute(substitute(expand("%"), "app\/", "spec/", ""), "\.rb$", "_spec.rb", "")

setlocal iskeyword+=?,!
