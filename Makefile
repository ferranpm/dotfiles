FILES = conkyrc\
				i3 \
				vim \
				vimrc\
				xinitrc\
				Xresources\
				zshrc

.PHONY: install $(FILES)

install: $(FILES)

$(FILES):
	cp -rTu $@ ~/.$@
