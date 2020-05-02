# TMUX - automatically attach the first session if not inside tmux and vim
if which tmux >/dev/null 2>&1; then
  if [ -z $VIM ] && [ $TERM != "linux" ]; then
    ID="$(tmux ls | head -1 | cut -d: -f1 )" # get the id of the first one

    if [[ -z "$ID" ]]; then # if not available create a new one
      tmux new-session
    else
      tmux attach-session -t "$ID" # if available attach to it
    fi
  fi
fi
