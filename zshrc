# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
DEFAULT_USER="sajoku"

#include some other files
. ~/dotfiles/aliases
. ~/dotfiles/functions

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Enable completion
autoload -U compinit
compinit

plugins=(git rails ruby bundler)

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef

#rvm_silence_path_mismatch_check_flag=1
#

source $ZSH/oh-my-zsh.sh

[ "$TERM" = "xterm" ] && TERM="xterm-256color"

export GOPATH=$HOME/gocode

unsetopt correct_all
export BUNDLER_EDITOR=mvim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

#export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
##export PATH=$PATH:/usr/local/opt/go/libexec/bin
##export PATH=$PATH:/usr/local/go/bin
##export PATH=$PATH:/usr/local/opt/go/libexec/bin #Add go gopath
#export PATH="$HOME/.bin:/usr/local/bin:$PATH"
#export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"
#export PATH=".git/safe/../../bin:$PATH"
