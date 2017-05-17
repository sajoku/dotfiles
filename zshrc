# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh
ZSH_THEME=""
DEFAULT_USER="sajoku"

#include some other files
source ~/dotfiles/aliases

# Save a ton of history
HISTSIZE=20000
HISTFILE=~/.zsh_history
SAVEHIST=20000

# Enable completion

autoload -U compinit
compinit

plugins=(git rails ruby bundler)

[ "$TERM" = "xterm" ] && TERM="xterm-256color"
source $ZSH/oh-my-zsh.sh

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


eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# --files: List files that would be searched but do not search
# --no-ignore: Do not respect .gitignore, etc...
# --hidden: Search hidden files and folders
# --follow: Follow symlinks
# --glob: Additional conditions for search (in this case ignore everything in the .git/ folder)
#export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*"'

eval "$(pyenv init -)"
if which pyenv-virtualenv-init > /dev/null; then eval "$(pyenv virtualenv-init -)"; fi


autoload -U promptinit; promptinit
prompt pure

. ~/dotfiles/pyenv-pure-prompt
