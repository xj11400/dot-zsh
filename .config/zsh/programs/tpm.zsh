# download tpm
# ------------

if [ "$(command -v tmux)" ]; then
    if [[ ! -d $XDG_DATA_HOME/tmux/plugins/tpm ]];then
        #download tpm
        x_use "tmux-plugins/tpm" $XDG_DATA_HOME/tmux/plugins/tpm
    fi
fi


