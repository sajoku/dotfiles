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

# Colorize terminal
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
export GREP_OPTIONS="--color"

if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

plugins=(git fzf asdf aws)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=green,bg=bold"

source $ZSH/oh-my-zsh.sh
export TERM="xterm-256color"

unsetopt correct_all

export BUNDLER_EDITOR=nvim
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export VISUAL=nvim
export EDITOR=$VISUAL

# ensure dotfiles bin directory is loaded first
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.bin:/usr/local/sbin:$PATH"
export PATH="$HOME/.bin:/usr/local/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"


_not_inside_tmux() { [[ -z "$TMUX" ]] }

ensure_tmux_is_running() {
  if _not_inside_tmux; then
    tat
  fi
}
ensure_tmux_is_running


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,.venv,.tox,coverage,tmp,.yarn,}/*" -g "!{.DS_Store,.keep}" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

source <(kubectl completion zsh)

export PATH="/usr/local/opt/gettext/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

# pyenv
eval "$(pyenv init -)"

#Direnv: Loads .envrc files 
eval "$(direnv hook zsh)"

eval "$(starship init zsh)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH=/opt/homebrew/bin:$PATH
export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

# completion for op (1password)
eval "$(op completion zsh)"; compdef _op op

#asdf
. /opt/homebrew/opt/asdf/libexec/asdf.sh
