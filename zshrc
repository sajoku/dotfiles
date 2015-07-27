# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME="agnoster"
DEFAULT_USER="sajoku"

#include some other files
. ~/dotfiles/aliases

# Base16 Shell
BASE16_SHELL="$HOME/playground/base16-shell/base16-monokai.dark.sh"
[[ -s $BASE16_SHELL ]] && source $BASE16_SHELL

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

source $ZSH/oh-my-zsh.sh

[ "$TERM" = "xterm" ] && TERM="xterm-256color"

export GOPATH=$HOME/gocode

unsetopt correct_all
export BUNDLER_EDITOR=vim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# use vim as the visual editor
export VISUAL=vim
export EDITOR=$VISUAL

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.bin:/usr/local/bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
export PATH="$PATH:$HOME/.rvm/bin"
export PATH=".git/safe/../../bin:$PATH"

# Add this to your zshrc or bzshrc file
_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}

ensure_tmux_is_running

alias tls="tmux list-sessions"
tm-select-session() {
  project=$(projects | fzf --reverse)
  if [ ! -z "$project" ]; then
    (cd "$project" && tat)
  fi
}
