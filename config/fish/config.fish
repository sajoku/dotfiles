#silence the welcome message
set -g fish_greeting

if status is-interactive
  # Commands to run in interactive sessions can go here
  set -gx DEFAULT_USER "sajoku"

  set -gx LC_ALL "en_US.UTF-8"
  set -gx LANG "en_US.UTF-8"

  set -gx VISUAL nvim
  set -gx EDITOR $VISUAL
  set -gx BUNDLER_EDITOR nvim


  set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor/bundle,.venv,.tox,coverage,tmp,.yarn,}/*" -g "!{.DS_Store,.keep}" 2> /dev/null'
  set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"

  #set -gx PYENV_ROOT "$HOME/.pyenv"


  # Aliases
  if [ -f $HOME/.config/fish/aliases.fish ]
    source $HOME/.config/fish/aliases.fish
  end


end

if status --is-login

  # Hide some things we never want to see :D
  set -gx PATH $PATH "$HOME/dotfiles/bin"
  set -gx PATH $PATH "$HOME/.bin:/usr/local/sbin"
  set -gx PATH $PATH "$HOME/.bin:/usr/local/bin"
  set -gx PATH $PATH "$HOME/.cargo/bin"
  set -gx PATH $PATH ".git/safe/../../bin"
  set -gx PATH $PATH "$HOME/go/bin"

  #set -gx PATH $PATH "PYENV_ROOT/bin:$PATH"
  set -gx PATH $PATH "/opt/homebrew/bin"
  set -gx PATH $PATH "/opt/homebrew/opt/openssl@3/bin"
  set -gx PATH $PATH $HOME"/.config/yarn/global/node_modules/.bin"

  #Make sure we always run with an active tmux session
  tmux_chooser
end

set -x SSH_AUTH_SOCK $HOME/.1password/agent.sock

pyenv init - | source
direnv hook fish | source
starship init fish | source

