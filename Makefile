FILES = conkyrc\
				vimrc\
				xinitrc\
				Xresources\
				zshrc

.PHONY: install $(FILES)

install: $(FILES)

$(FILES):
	cp $@ ~/.$@
