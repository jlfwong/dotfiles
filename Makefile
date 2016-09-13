SHELL := /bin/bash

all: submodules link bundleinstall brewinstall

brewinstall:
	brew install tmux zsh fzf

fzfinstall:
	brew install fzf

link: .vim .vimrc .gvimrc .ackrc .gitconfig .screenrc .ctags .gitignore_global .hgrc .hgext .inputrc .tmux.conf .zshrc .bash_profile .oh-my-zsh
	-$(foreach file, $^, ln -s $(CURDIR)/$(file) ~; )

bundleinstall:
	vim +BundleInstall +qall

submodules:
	git submodule update --init --recursive
