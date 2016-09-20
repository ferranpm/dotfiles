set makeprg=mocha\ test/unit\ --reporter\ tap\ 2>/dev/null
set errorformat=%Enot\ ok\ %n\ %.%#,%C%.%#AssertionError:\ %m,%Z%.%#(%f:%l:%c)
