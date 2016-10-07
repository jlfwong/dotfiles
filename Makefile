SHELL := /bin/bash

all: submodules link bundleinstall brewinstall

brewinstall:
	brew install tmux zsh fzf ripgrep

fzfinstall:
	brew install fzf

link: .vim .vimrc .gvimrc .ackrc .gitconfig .screenrc .ctags .gitignore_global .hgrc .hgext .inputrc .tmux.conf .zshrc .bash_profile .oh-my-zsh
	-$(foreach file, $^, ln -s $(CURDIR)/$(file) ~; )

bundleinstall:
	vim +BundleInstall +qall

submodules:
	git submodule update --init --recursive

# NOTE: This is intentionally not included as part of all:
casks:
	brew cask install spotify dropbox spectacle karabiner flux iterm2 google-chrome
