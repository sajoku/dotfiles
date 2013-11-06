# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#include some other files
. ~/dotfiles/aliases

ZSH_THEME="agnoster"
DEFAULT_USER="sajoku"

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

plugins=(git rails ruby pow bundler rvm urltools)

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

PATH="${PATH}:/Users/sander/bin"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=/usr/local/bin:$PATH # Add RVM to PATH for scripting
PATH=/usr/local/sbin:$PATH # Add RVM to PATH for scripting
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

unsetopt correct_all
