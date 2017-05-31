SHELL := /bin/bash

all: submodules link bundleinstall brewinstall fzfinstall

brewinstall:
	brew install tmux zsh fzf ripgrep hub

fzfinstall:
	/usr/local/opt/fzf/install --key-bindings --completion --no-update-rc

link: .vim .vimrc .gvimrc .ideavimrc .ackrc .gitconfig .screenrc .ctags .gitignore_global .hgrc .hgext .inputrc .tmux.conf .zshrc .bash_profile .oh-my-zsh
	-$(foreach file, $^, ln -s $(CURDIR)/$(file) ~; )

linkvscode:
	rm -rf "/Users/jlfwong/Library/Application Support/Code/User/settings.json"
	ln -s $(CURDIR)/vscode_settings.json "/Users/jlfwong/Library/Application Support/Code/User/settings.json"

bundleinstall:
	vim +BundleInstall +qall
	cd ~/.vim/bundle/YouCompleteMe/ && ./install.py --clang-completer

submodules:
	git submodule update --init --recursive

# NOTE: This is intentionally not included as part of all:
casks:
	brew cask install spotify dropbox spectacle karabiner flux iterm2 google-chrome
	source karabiner.sh
