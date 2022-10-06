function tmux_chooser --description "Making sure we always run in tmux"
  if test "$TMUX" != ""
    return
  end

  tat
end
