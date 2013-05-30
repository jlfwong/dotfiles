SHELL := /bin/bash

all: submodules link

link: .vim .vimrc .gvimrc .ackrc .gitconfig .screenrc .ctags .gitignore_global .hgrc .hgext .inputrc .slate .tmux.conf .zshrc .bash_profile .oh-my-zsh
	$(foreach file, $^, ln -s $(CURDIR)/$(file) ~; )

submodules:
	git submodule init
	git submodule update
