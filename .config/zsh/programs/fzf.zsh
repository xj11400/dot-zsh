declare FZF_PATH=$XDG_DATA_HOME/fzf

# download fzf
# ------------
if [[ ! -d $XDG_DATA_HOME/fzf ]];then
    #download fzf
    x_use "junegunn/fzf" $FZF_PATH
    #install fzf
    bash -c "$FZF_PATH/install --xdg --key-bindings --completion --no-update-rc --bin --no-bash --no-zsh --no-fish"
fi


# setup fzf
# ---------
if [[ -z $(command -v fzf) ]];then
    if [[ ! "$PATH" == *$FZF_PATH/bin* ]]; then
      export PATH="${PATH:+${PATH}:}$FZF_PATH/bin"
    fi
fi


# auto-completion
# ---------------
[[ $- == *i* ]] && source "$FZF_PATH/shell/completion.zsh" 2> /dev/null

# key bindings
# ------------
source "$FZF_PATH/shell/key-bindings.zsh"

# show dot files
# --------------
export FZF_DEFAULT_COMMAND='ag -l --path-to-ignore ~/.ignore --nocolor --hidden -g ""'
