let g:projectionist_heuristics = {
      \ 'config/routes.rb': {
      \   'app/commands/*.rb': {
      \     'type': 'command',
      \     'alternate': [ 'spec/commands/{}_spec.rb' ],
      \     },
      \   'app/services/*.rb': {
      \     'type': 'service',
      \     'alternate': [ 'spec/services/{}_spec.rb' ],
      \     },
      \   'app/facets/*.rb': {
      \     'type': 'facet',
      \     'alternate': [ 'spec/facets/{}_spec.rb' ],
      \     },
      \   'app/mailers/*_mailer.rb': {
      \     'type': 'mailer',
      \     'alternate': [ 'spec/mailers/{}_spec.rb' ],
      \     },
      \   'app/controllers/*_controller.rb': {
      \     'type': 'controller',
      \     'alternate': [ 'spec/controllers/{}_controller_spec.rb', 'app/models/{singular}.rb' ],
      \     },
      \   'app/helpers/*_helper.rb': {
      \     'type': 'helper',
      \     'alternate': [ 'app/controllers/{}_controller.rb' ],
      \     },
      \   'config/initializers/*.rb': {
      \     'type': 'initializer',
      \     },
      \   'app/models/*.rb': {
      \     'type': 'model',
      \     'alternate': [ 'spec/models/{}_spec.rb', 'app/controllers/{plural}_controller.rb' ],
      \     },
      \   'app/views/*.html.erb': {
      \     'type': 'view',
      \     'alternate': [ 'app/controllers/{dirname}_controller.rb' ],
      \     },
      \   'lib/*.rb': {
      \     'type': 'lib',
      \     'alternate': [ 'spec/lib/{}_spec.rb' ],
      \     },
      \   'app/*.rb': {
      \     'alternate': [ 'spec/{}_spec.rb' ],
      \     },
      \   'spec/*_spec.rb': {
      \     'alternate': [ 'app/{}.rb' ],
      \     }
      \   }
      \ }
