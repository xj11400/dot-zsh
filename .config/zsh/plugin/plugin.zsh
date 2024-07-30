#
#
# 

# plugin config
# source $X_ZSH_PLUGIN_HOME/pre_config.zsh

load_plugin_manager() {
    local plugin_manager="$1"
    local plugin_manager_path="$X_ZSH_PLUGIN_HOME/zpm/$plugin_manager/$plugin_manager.zsh"

    if [[ -d "$X_ZSH_PLUGIN_HOME/zpm/$plugin_manager" ]]; then
        source "$plugin_manager_path"
    else
        echo "You don't have this plugin manager: $plugin_manager" >&2
        return 1
    fi

    # plugin config
    source "$X_ZSH_PLUGIN_HOME/config.zsh"

    # load user
    # load_user plugin
}

# Call the function with $X_ZSH_PLUGIN_MANAGER
load_plugin_manager "$X_ZSH_PLUGIN_MANAGER"