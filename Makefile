SHELL := /bin/bash

all: submodules link

link: .vim .vimrc .gvimrc .ackrc .gitconfig .screenrc .ctags .gitignore_global
	$(foreach file, $^, ln -s $(CURDIR)/$(file) ~; )

submodules:
	git submodule init
	git submodule update

native: CommandT

CommandT: 
	cd ~/.vim/bundle/Command-T/ruby/command-t && \
	ruby extconf.rb && \
	make
