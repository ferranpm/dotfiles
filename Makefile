FILES = conkyrc\
				i3 \
				vimrc\
				xinitrc\
				Xresources\
				zshrc

.PHONY: install $(FILES)

install: $(FILES)

$(FILES):
	cp -ru $@ ~/.$@
