# Silence the welcome message
set -g fish_greeting

if status is-interactive
    set -gx DEFAULT_USER "sajoku"
    set -gx LC_ALL "en_US.UTF-8"
    set -gx LANG "en_US.UTF-8"
    set -gx VISUAL nvim
    set -gx EDITOR $VISUAL
    set -gx BUNDLER_EDITOR nvim
    set -gx FZF_DEFAULT_COMMAND 'rg --files --no-ignore --hidden --follow -g "!{.git,node_modules,vendor/bundle,.venv,.tox,coverage,tmp,.yarn,}/*" -g "!{.DS_Store,.keep}" 2> /dev/null'
    set -gx FZF_CTRL_T_COMMAND "$FZF_DEFAULT_COMMAND"
    set -gx SSH_AUTH_SOCK $HOME/.1password/agent.sock

    if test -f $HOME/.config/fish/aliases.fish
        source $HOME/.config/fish/aliases.fish
    end

    pyenv init - | source
    starship init fish | source
    mise activate fish | source
end

if status is-login
    # Homebrew first so it takes priority
    fish_add_path /opt/homebrew/bin
    fish_add_path /opt/homebrew/opt/openssl@3/bin
    fish_add_path $HOME/dotfiles/bin
    fish_add_path $HOME/.bin
    fish_add_path $HOME/.local/bin
    fish_add_path $HOME/.cargo/bin
    fish_add_path $HOME/go/bin
    fish_add_path $HOME/.config/yarn/global/node_modules/.bin

    tmux_chooser
end
