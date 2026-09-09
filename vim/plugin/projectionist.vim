let g:projectionist_heuristics = {}

let g:projectionist_heuristics['config/routes.rb'] = {
      \   "app/models/*.rb": {
      \     "type": "model",
      \   },
      \   "app/services/*.rb": {
      \     "type": "service",
      \   },
      \   "app/controllers/*_controller.rb": {
      \     "type": "controller",
      \   },
      \   "app/*.rb": {
      \     "alternate": "spec/{}_spec.rb",
      \   },
      \   "spec/*_spec.rb": {
      \     "alternate": "app/{}.rb",
      \   },
      \ }

" Iterate each directory in packs/ and append the same euristics as app/
for pack in globpath('packs', '*', 1, 1)
  let pack_name = fnamemodify(pack, ':t')
  let g:projectionist_heuristics['packs/'.pack_name.'/package.yml'] = {
      \   "packs/".pack_name."/app/models/*.rb": {
      \     "type": "model",
      \     "alternate": "packs/".pack_name."/spec/models/{}_spec.rb",
      \   },
      \   "packs/".pack_name."/app/services/*.rb": {
      \     "type": "service",
      \     "alternate": "packs/".pack_name."/spec/services/{}_spec.rb",
      \   },
      \   "packs/".pack_name."/app/controllers/*_controller.rb": {
      \     "type": "controller",
      \     "alternate": "packs/".pack_name."/spec/controller/{}_spec.rb",
      \   },
      \   "packs/".pack_name."/app/*.rb": {
      \     "alternate": "packs/".pack_name."/spec/{}_spec.rb",
      \   },
      \   "packs/".pack_name."/spec/*_spec.rb": {
      \     "alternate": "packs/".pack_name."/app/{}.rb",
      \   },
      \ }
endfor
