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

plugins=(git zsh-syntax-highlighting osx pip)

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
export PATH="$HOME/dotfiles/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"

# mkdir .git/safe in the root of repositories you trust
export PATH=".git/safe/../../bin:$PATH"

#Add support for gpg and commit signing
GPG_TTY=$(tty)
export GPG_TTY

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

# Add gpg agent so wecan use signed commits and do not have to fill in creds every commit
if test -f ~/.gnupg/.gpg-agent-info -a -n "$(pgrep gpg-agent)"; then
  source ~/.gnupg/.gpg-agent-info
  export GPG_AGENT_INFO
  GPG_TTY=$(tty)
  export GPG_TTY
#else
#  eval $(gpg-agent --daemon)
fi


eval "$(rbenv init -)"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules}/*" 2> /dev/null'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

eval "$(pyenv init -)"

# autoload -U promptinit; promptinit
# . ~/dotfiles/pyenv-pure-prompt
# PURE_PROMPT_SYMBOL="➜"
# prompt pure

function zle-line-init zle-keymap-select {
  PROMPT=`~/code/purs/target/release/purs prompt -k "$KEYMAP" -r "$?"`
  zle reset-prompt
}
zle -N zle-line-init
zle -N zle-keymap-select

autoload -Uz add-zsh-hook

function _prompt_purs_precmd() {
  ~/code/purs/target/release/purs precmd
}
add-zsh-hook precmd _prompt_purs_precmd

export PYTHON_CONFIGURE_OPTS="--enable-framework"

BASE16_SHELL=$HOME/.config/base16-shell/
[ -n "$PS1" ] && [ -s $BASE16_SHELL/profile_helper.sh ] && eval "$($BASE16_SHELL/profile_helper.sh)"
export PATH="/usr/local/opt/gettext/bin:$PATH"
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
# Keep pipenv packages inside projects instead of home directory (This is what's being done in production so mimick that behaviour)
PIPENV_VENV_IN_PROJECT=1
