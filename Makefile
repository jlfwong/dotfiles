SHELL := /bin/bash

all: link submodules

link: .vim .vimrc
	@for targ in $^; do \
		echo Linking $$targ; \
		ln -s `pwd`/$$targ ~; \
	done

submodules:
	git submodule init
	git submodule update
