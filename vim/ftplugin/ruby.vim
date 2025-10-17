if exists("b:ruby_ftplugin")
  finish
endif
let b:ruby_ftplugin = 1

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

map <buffer><silent> ]] /\m\<def\><cr>
map <buffer><silent> [[ ?\m\<def\><cr>

iabbrev db require "debug"; debugger
iabbrev bb require "debug"; binding.b
iabbrev bp require "pry"; binding.pry

command! -buffer -nargs=* -complete=file Reek compiler reek | make <args>
command! -buffer -nargs=* -complete=file Rubocop compiler rubocop | make <args>
command! -buffer Pronto compiler pronto | make
command! -buffer RSpec compiler rspec | execute "make :".line(".")
command! -buffer RSpecDocker compiler rspec-docker | execute "make :".line(".")
command! -buffer -range HashToJson s/=>/:/e | s/\<nil\>/null/e | .!json_pp

nnoremap <buffer> <silent> <leader>T :update \| RSpecDocker<cr>
nnoremap <buffer> <silent> <leader>t :update \| call RubyTest()<cr>

function! RubyTest()
  let line = line(".")
  let filename = expand("%")

  let @* = s:rspec_executable() . " " . filename . ":" . line

  echo "Test copied: ".@*
endfunction

function! s:rspec_executable()
  if filereadable("./bin/rspec")
    return "./bin/rspec"
  elseif filereadable("Gemfile")
    return "bundle exec rspec"
  else
    return "rspec"
  endif
endfunction

command! -buffer CreateSpecFile execute 'split | edit '.substitute(substitute(expand("%"), "app\/", "spec/", ""), "\.rb$", "_spec.rb", "")

setlocal path=,,app/**,packs/*/app/**

setlocal iskeyword+=?,!
setlocal foldmethod=expr
setlocal foldexpr=v:lua.vim.treesitter.foldexpr()
