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


  # Hide some things we never want to see :D
  set -x export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,.venv,.tox,coverage,tmp,.yarn,}/*" -g "!{.DS_Store,.keep}" 2> /dev/null'

  #set -gx PYENV_ROOT "$HOME/.pyenv"


  # Aliases
  if [ -f $HOME/.config/fish/aliases.fish ]
    source $HOME/.config/fish/aliases.fish
  end


end

if status --is-login
  set -gx PATH $PATH "$HOME/dotfiles/bin"
  set -gx PATH $PATH "$HOME/.bin:/usr/local/sbin"
  set -gx PATH $PATH "$HOME/.bin:/usr/local/bin"
  set -gx PATH $PATH "$HOME/.cargo/bin"
  set -gx PATH $PATH ".git/safe/../../bin"

  #set -gx PATH $PATH "PYENV_ROOT/bin:$PATH"
  set -gx PATH $PATH "$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin"
  set -gx PATH $PATH "/opt/homebrew/bin"
  set -gx PATH $PATH "/opt/homebrew/opt/openssl@3/bin"
 
  #Make sure we always run with an active tmux session
  tmux_chooser
end

# Fish syntax highlighting
set -g fish_color_autosuggestion '555'  'brblack'
set -g fish_color_cancel -r
set -g fish_color_command --bold
set -g fish_color_comment red
set -g fish_color_cwd green
set -g fish_color_cwd_root red
set -g fish_color_end brmagenta
set -g fish_color_error brred
set -g fish_color_escape 'bryellow'  '--bold'
set -g fish_color_history_current --bold
set -g fish_color_host normal
set -g fish_color_match --background=brblue
set -g fish_color_normal normal
set -g fish_color_operator bryellow
set -g fish_color_param cyan
set -g fish_color_quote yellow
set -g fish_color_redirection brblue
set -g fish_color_search_match 'bryellow'  '--background=brblack'
set -g fish_color_selection 'white'  '--bold'  '--background=brblack'
set -g fish_color_user brgreen
set -g fish_color_valid_path --underline

pyenv init - | source
direnv hook fish | source
starship init fish | source

source /opt/homebrew/opt/asdf/libexec/asdf.fish
