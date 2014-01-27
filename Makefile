SHELL := /bin/bash

all: submodules matcher-build reattach-to-user-namespace-build link bundleinstall

matcher-build:
	cd matcher; make

reattach-to-user-namespace-build:
	# TODO(jlfwong): Bail out on non-osx?
	mkdir -p ~/bin
	(cd tmux-MacOSX-pasteboard && make reattach-to-user-namespace && cp reattach-to-user-namespace ~/bin)

link: .vim .vimrc .gvimrc .ackrc .gitconfig .screenrc .ctags .gitignore_global .hgrc .hgext .inputrc .slate .tmux.conf .zshrc .bash_profile .oh-my-zsh
	-$(foreach file, $^, ln -s $(CURDIR)/$(file) ~; )

bundleinstall:
	vim +BundleInstall +qall

submodules:
	git submodule update --init --recursive
