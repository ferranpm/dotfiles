let g:projectionist_heuristics = {
      \ 'config/routes.rb': {
      \   'app/services/*.rb': {
      \     'type': 'service',
      \     'alternate': [ 'spec/services/{}_spec.rb' ],
      \     },
      \   'app/views/*.json.jbuilder': {
      \     'type': 'builder',
      \     'alternate': 'app/controllers/{dirname}_controller.rb',
      \     },
      \   'app/controllers/*_controller.rb': {
      \     'type': 'controller',
      \     'alternate': 'app/models/{singular}.rb',
      \     },
      \   'app/helpers/*_helper.rb': {
      \     'type': 'helper',
      \     'alternate': 'app/controllers/{}_controller.rb',
      \     },
      \   'config/initializers/*.rb': {
      \     'type': 'initializer',
      \     },
      \   'app/javascript/*.js': {
      \     'type': 'javascript',
      \     },
      \   'app/models/*.rb': {
      \     'type': 'model',
      \     'alternate': [ 'spec/models/{}_spec.rb', 'app/controllers/{plural}_controller.rb' ],
      \     },
      \   'app/javascript/stylesheets/*.scss': {
      \     'type': 'stylesheets',
      \     },
      \   'spec/*_spec.rb': {
      \     'type': 'spec',
      \     'alternate': [ 'app/{}.rb', '{}.rb' ],
      \     },
      \   'app/views/*.html.erb': {
      \     'type': 'view',
      \     'alternate': 'app/controllers/{dirname}_controller.rb',
      \     },
      \   }
      \ }
