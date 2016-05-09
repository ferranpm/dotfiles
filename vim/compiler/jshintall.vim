setlocal makeprg=ag\ -0\ --ignore-dir\ public\ -g\ \".js$\"\ \|\ xargs\ -0\ jshint
setlocal errorformat=%f:\ line\ %l\\,\ col\ %c\\,\ %m
