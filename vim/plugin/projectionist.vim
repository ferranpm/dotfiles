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
