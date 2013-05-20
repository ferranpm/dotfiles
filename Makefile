FILES = conkyrc\
				vimrc\
				xinitrc\
				Xresources\
				zshrc

install: $(FILES)

$(FILES):
	cp .$@ ~
