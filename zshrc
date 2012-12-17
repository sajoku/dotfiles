# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

#include some other files
. ~/dotfiles/aliases

#ZSH_THEME="robbyrussell"
#ZSH_THEME="af-magic"
ZSH_THEME="agnoster"
DEFAULT_USER="sajoku"


# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails ruby pow bundler)

[[ -s "/Users/sander/.rvm/scripts/rvm" ]] && source "/Users/sander/.rvm/scripts/rvm" # #Load RVM into a shell session *as a function*

PATH="${PATH}:/Users/sander/bin"

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
PATH=/usr/local/bin:$PATH # Add RVM to PATH for scripting
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"

unsetopt correct_all
