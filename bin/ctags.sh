#!/bin/sh

for f in $*; do
    case $f in
        *.c)
            gcc -M $* | sed -e 's/[\\ ]/\n/g' | sed -e '/^$/d' -e '/\.o:[ \t]*$/d' | ctags -L - --append
            ;;
        *)
            ctags --append $f
    esac
done
