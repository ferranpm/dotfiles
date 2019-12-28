if exists("b:ruby_ftplugin")
  finish
endif
let b:ruby_ftplugin = 1

setlocal softtabstop=2
setlocal tabstop=2
setlocal shiftwidth=2

map <silent> ]] /\m\<def\><cr>
map <silent> [[ ?\m\<def\><cr>

if !exists("g:ruby_spring")
  let g:ruby_spring = 1
endif

nnoremap <buffer> <expr> <silent> <leader>t RubyTest()

function! RubyTest()
  let line = line(".")
  let filename = expand("%")
  let spring = g:ruby_spring ? "spring " : ""
  let @*="bundle exec ".spring."rspec ".filename.":".line
endfunction

iabbrev bp binding.pry

command! RoR !open "https://api.rubyonrails.org/?q=<cword>"
command! Rb !open "https://ruby-doc.com/search.html?q=<cword>"
command! -buffer -range HashToJson s/=>/:/e | s/\<nil\>/null/e | .!json_pp
