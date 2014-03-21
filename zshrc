# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
DEFAULT_USER="sajoku"
# Base16 Shell
BASE16_SCHEME="eighties"
BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
[[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

#include some other files
. ~/dotfiles/aliases
. ~/dotfiles/functions

# Allow completing of the remainder of a command
bindkey "^N" insert-last-word

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

#Show contents of directory after cd-ing into it
chpwd() {
  ls -lrthG
}

# Enable completion
autoload -U compinit
compinit

plugins=(git rails ruby bundler)

# Disable flow control commands (keeps C-s from freezing everything)
stty start undef
stty stop undef


#rvm_silence_path_mismatch_check_flag=1

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
source $ZSH/oh-my-zsh.sh

#export PATH="/usr/local/bin:/usr/local/sbin:~/bin:$PATH"

[ "$TERM" = "xterm" ] && TERM="xterm-256color"

export GOPATH=$HOME/gocode

unsetopt correct_all
