BASE16_SHELL="$HOME/dotfiles/base16-shell/base16-default.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="phleet"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(gitfast zsh-syntax-highlighting)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

export PATH="/usr/local/mongodb/bin:$PATH"
export PATH="/usr/texbin:$PATH"
export PATH="$HOME/bin:$PATH"
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export DYLD_LIBRARY_PATH="/usr/local/mysql/lib:$DYLD_LIBRARY_PATH"

export PATH="/usr/local/bin:/Developer/usr/bin:/usr/local/git/bin/:$PATH"
export PATH="$HOME/.rbenv/bin:$PATH"
export PATH="/usr/local/share/npm/bin:$PATH"

alias wiki="cd ~/wiki && SOYWIKI_VIM=vim soywiki && cd -"

bindkey -v
bindkey '^R' history-incremental-search-backward
bindkey -M vicmd v edit-command-line

function notify {
  ret=$?
  if [ $ret -eq 0 ]; then
    echo -e "\033[1;32m[ DONE ]\033[0m"
    ( say -v 'Good News' "Done" & )
  elif [ $status -ne 130 ]; then  # Ignore exit with Ctrl-C
    echo -e "\033[1;31m[ ERROR $ret ]\033[0m"
    ( say -v Cellos "Oh noes, exit code $ret" & )
  fi
  return $status
}

if [ -d "$HOME/.rvm" ]; then
    source $HOME/.rvm/scripts/rvm
    PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
