SHELL := /bin/bash

all: submodules link

link: .vim .vimrc .gvimrc
	@for targ in $^; do \
		echo Linking $$targ; \
		ln -s `pwd`/$$targ ~; \
	done

submodules:
	git submodule init
	git submodule update

native: CommandT

CommandT: 
	cd ~/.vim/bundle/Command-T/ruby/command-t && \
	ruby extconf.rb && \
	make
