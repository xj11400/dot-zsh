#
# x_init.zsh
# ############################################################

export ZDOTDIR="$HOME/.config/zsh"

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
# Function to source a specific .zsh file from X_ZSH_CONFIG_HOME
# Usage: x_zsh_load "filename.zsh"
# This will attempt to source X_ZSH_CONFIG_HOME/filename.zsh
function x_zsh_load(){
    [[ -f "$X_ZSH_CONFIG_HOME/$1" ]] && source "$X_ZSH_CONFIG_HOME/$1" || echo "Warning: $1 not found"
}

# Function to source a specific .zsh file from X_ZSH_CONFIG_HOME
# Usage: x_zsh_require "module_name"
# This will attempt to source X_ZSH_CONFIG_HOME/module_name/module_name.zsh
function x_zsh_require(){
    local file="$X_ZSH_CONFIG_HOME/$1/$1.zsh"
    [[ -f "$file" ]] && source "$file" || echo "Warning: $file not found"
}

# Function to source all .zsh files in a specified directory within X_ZSH_CONFIG_HOME
# Usage: x_zsh_require_dir "subdirectory_name"
function x_zsh_require_dir(){
    local dir="$X_ZSH_CONFIG_HOME/$1"
    if [[ -d "$dir" ]]; then
        # Get all .zsh files in the directory (N flag for null_glob)
        local files=("$dir"/*.zsh(N))
        if (( ${#files} )); then
            # If files exist, source each one
            for file in "${files[@]}"; do
                source "$file"
            done
        fi
        # Note: If no .zsh files are found, the function silently does nothing
    else
        echo "Warning: Directory $dir not found"
    fi
}

# [REMOVE]
function x_zsh_require_x(){
    # local dir="$X_ZSH_CONFIG_HOME/$1"
    # if [[ -d "$dir" ]]; then
    #     local files=("$dir"/*.x.zsh(N))
    #     if (( ${#files} )); then
    #         for file in "${files[@]}"; do
    #             source "$file"
    #         done
    #     fi
    # else
    #     echo "Warning: Directory $dir not found"
    # fi
    echo "xxxxxxxxxxxxxxxxxxxxxxxxxxxxx"
}

# Function to load user-specific Zsh configurations
# Usage:
#   load_user          - Load all user configs except plugin.zsh and theme.zsh
#   load_user plugin   - Load only plugin.zsh
#   load_user theme    - Load only theme.zsh
function load_user() {
    local user_dir="$X_ZSH_CONFIG_HOME/user"
    
    # Check if the user directory exists
    if [[ ! -d "$user_dir" ]]; then
        echo "Warning: User directory $user_dir not found"
        return 1
    fi

    case "$1" in
        plugin)
            # Load only plugin.zsh if it exists
            [[ -f "$user_dir/plugin.zsh" ]] && source "$user_dir/plugin.zsh"
            ;;
        theme)
            # Load only theme.zsh if it exists
            [[ -f "$user_dir/theme.zsh" ]] && source "$user_dir/theme.zsh"
            ;;
        *)
            # Load all .zsh files except plugin.zsh and theme.zsh
            local files=("$user_dir"/*.zsh(N))
            for file in "${files[@]}"; do
                if [[ "$(basename "$file")" != "plugin.zsh" && "$(basename "$file")" != "theme.zsh" ]]; then
                    source "$file"
                fi
            done
            ;;
    esac
}

# pre load
# ========
x_zsh_require_dir utils
source $X_ZSH_CONFIG_HOME/platform/${MY_OS}.zsh

# user - pre
[[ -f "$X_ZSH_CONFIG_HOME/user/pre_load.zsh" ]] && source $X_ZSH_CONFIG_HOME/user/pre_load.zsh

# load files
# ==========

# config
x_zsh_load x_config

# core
x_zsh_require core

# NOTE: load user options before theme and plugin
# user foloder is on for temperary setting environment
# export X_J=${X_J:-"ANTIDOTE"}
# NOTE: 
#     - programs
#     - load_user
#     - plugin
#       - load_user plugin
#     - theme
#       - load_user theme
#
# NOTE: load function should add 's' after config.zsh
#


# theme
x_zsh_require theme

# plugin
x_zsh_require plugin

# programs
x_zsh_require_dir programs

# user
# if [[ -d "$X_ZSH_CONFIG_HOME/user" && $(ls -A $X_ZSH_CONFIG_HOME/user) ]];then
#     x_zsh_require_dir user
# fi
load_user

# unset function
unset -f x_zsh_require
unset -f x_zsh_require_x
unset -f x_zsh_require_dir
unset -f x_zsh_load