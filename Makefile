SHELL := /bin/bash

all: submodules link bundleinstall brewinstall fzfinstall macos

brewinstall:
	brew install tmux zsh fzf ripgrep hub reattach-to-user-namespace

fzfinstall:
	/usr/local/opt/fzf/install --key-bindings --completion --no-update-rc

link: .vim .vimrc .gvimrc .ideavimrc .ackrc .gitconfig .screenrc .ctags .gitignore_global .hgrc .hgext .inputrc .tmux.conf .zshrc .bash_profile .oh-my-zsh .irbrc
	-$(foreach file, $^, ln -s $(CURDIR)/$(file) ~; )

linkvscode:
	rm -rf "/Users/jlfwong/Library/Application Support/Code/User/settings.json"
	ln -s $(CURDIR)/vscode_settings.json "/Users/jlfwong/Library/Application Support/Code/User/settings.json"
	rm -rf "/Users/jlfwong/Library/Application Support/Code/User/keybindings.json"
	ln -s $(CURDIR)/vscode_keybindings.json "/Users/jlfwong/Library/Application Support/Code/User/keybindings.json"

bundleinstall:
	vim +BundleInstall +qall

submodules:
	git submodule update --init --recursive

# NOTE: This is intentionally not included as part of all:
casks:
	brew cask install spotify dropbox karabiner iterm2 google-chrome

macos:
	./macos.sh
