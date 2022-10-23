#
# x_init.zsh
# ############################################################

# ZDOTDIR="$HOME/.config/zsh"

# X_ZSH variables
# ===============

X_ZSH_CONFIG_HOME="$HOME/.config/zsh"
X_ZSH_DATA_HOME="$HOME/.local/share/zsh"

X_ZSH_PLUGIN_HOME="$X_ZSH_CONFIG_HOME/plugin"
X_ZSH_THEME_HOME="$X_ZSH_CONFIG_HOME/theme"
X_ZSH_CORE_HOME="$X_ZSH_CONFIG_HOME"

X_ZSH_THEME_DATA_HOME="$X_ZSH_DATA_HOME/theme"
X_ZSH_PLUGIN_MANAGER_HOME="$X_ZSH_DATA_HOME/zpm"
X_ZSH_PLUGIN_DATA_HOME="$X_ZSH_DATA_HOME/plugin"

# x_zsh functions
# ===============
function x_zsh_load(){
    source $X_ZSH_CONFIG_HOME/$1
}

function x_zsh_require(){
    source $X_ZSH_CONFIG_HOME/$1/$1.zsh
}

function x_zsh_require_dir(){
    for file in `ls $X_ZSH_CONFIG_HOME/$1/*.zsh`
    do
        source $file
    done
}

function x_zsh_require_x(){
    for file in `ls $X_ZSH_CONFIG_HOME/$1/*.x.zsh`
    do
        source $file
    done
}

# pre load
# ========
source $X_ZSH_CONFIG_HOME/utils/os.zsh
source $X_ZSH_CONFIG_HOME/platform/${MY_OS:l}.zsh

# custom - pre
if [[ -f "$X_ZSH_CONFIG_HOME/custom/pre_load.zsh" ]];then
    source $X_ZSH_CONFIG_HOME/custom/pre_load.zsh
fi

# load files
# ==========

# config
x_zsh_load x_config

# core
x_zsh_require core

# theme
x_zsh_require theme

# plugin
x_zsh_require plugin

# programs
x_zsh_require_dir programs

# custom
if [[ -d "$X_ZSH_CONFIG_HOME/custom" && $(ls -A $X_ZSH_CONFIG_HOME/custom) ]];then
    x_zsh_require_dir custom
fi

# unset function
unset -f x_zsh_require
unset -f x_zsh_require_x
unset -f x_zsh_require_dir
unset -f x_zsh_load

