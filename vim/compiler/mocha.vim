setlocal makeprg=./node_modules/.bin/mocha\ test/unit\ --reporter\ tap\ 2>/dev/null
setlocal errorformat=%Enot\ ok\ %n\ %.%#,%C%.%#AssertionError:\ %m,%Z%.%#(%f:%l:%c)
