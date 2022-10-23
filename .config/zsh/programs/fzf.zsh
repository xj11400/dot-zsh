# download fzf
# ------------
if [[ ! -d $XDG_DATA_HOME/fzf ]];then
    #download fzf
    x_use "junegunn/fzf" $XDG_DATA_HOME/fzf
    #install fzf
    bash -c "$XDG_DATA_HOME/fzf/install --xdg --key-bindings --completion --no-update-rc --bin --no-bash --no-zsh --no-fish"
fi

# setup fzf
# ---------
if [[ ! "$PATH" == */home/$USERNAME/.local/share/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/$USERNAME/.local/share/fzf/bin"
fi

# auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/$USERNAME/.local/share/fzf/shell/completion.zsh" 2> /dev/null

# key bindings
# ------------
source "/home/$USERNAME/.local/share/fzf/shell/key-bindings.zsh"

# show dot files
# --------------
export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
