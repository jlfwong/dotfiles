set -o vi

source ~/dotfiles/autojmp.bash
source ~/dotfiles/git-completion.bash

export GIT_PS1_SHOWDIRTYSTATE=true
export GIT_PS1_SHOWSTASHSTATE=true
export GIT_PS1_SHOWUNTRACKEDFILES=true
export GIT_PS1_ENABLED=true
function disable_git_ps1
{
  export GIT_PS1_ENABLED=false
}

function enable_git_ps1
{
  export GIT_PS1_ENABLED=true
}

export PS1='\e[33m\][\W] \e[32m\]$($GIT_PS1_ENABLED && __git_ps1 "(%s) ")\e[0m\]'

export CLICOLOR=1
export EDITOR=/usr/bin/vim

alias pyserve="python -m SimpleHTTPServer"
