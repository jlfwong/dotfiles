SHELL := /bin/bash
link: .vim .vimrc
	@for targ in $^; do \
		echo Linking $$targ; \
		ln -s `pwd`/$$targ ~; \
	done
