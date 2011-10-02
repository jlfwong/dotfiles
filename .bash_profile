set -o vi

source ~/dotfiles/autojmp.bash
source ~/dotfiles/git-completion.bash

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true

export PS1='╭─\e[33m\][\w] \e[32m\]$(__git_ps1 "(%s)")\n\e[0m\]╰─\$ '
export CLICOLOR=1
export EDITOR=/usr/bin/vim

alias pyserve="python -m SimpleHTTPServer"
