function tmux_chooser --description "Run in tmux, unless already in tmux or Rex"
    if set -q TMUX; or set -q REX_SESSION
        return
    end

    tat
end
