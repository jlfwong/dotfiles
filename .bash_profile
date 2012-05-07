set -o vi

source ~/dotfiles/autojmp.bash
source ~/dotfiles/git-completion.bash
source ~/dotfiles/hg-completion.bash

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

function git_ps1
{
  $GIT_PS1_ENABLED && __git_ps1 "(%s) "
}

function hg_ps1
{
  hg prompt "({branch}{@{bookmark}}{ {status}}) " 2> /dev/null
}

PROMPT_COMMAND='bpwd=$(basename `pwd`); echo -ne "\033]0;\007\033k${bpwd}\033\\"'

export PS1='\e[33m\][\W] \e[32m\]$(git_ps1)\e[31m\]$(hg_ps1)\e[0m\]'

export CLICOLOR=1
export EDITOR=/usr/bin/vim

alias pyserve="python -m SimpleHTTPServer"
alias g="git"
