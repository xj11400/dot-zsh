#!/bin/zsh
#
# x.zsh :
#   - variables for X_ZSH
#   - functions for x_zsh
#

# Check if _is_x_zsh_func is already set
if [[ -n "$_is_x_zsh_func" ]]; then
    return 0
fi

# Set _is_x_zsh_func to indicate that this file has been loaded
export _is_x_zsh_func=1

# X_ZSH variables
# ===============

X_ZSH_CONFIG_HOME="$XDG_CONFIG_HOME/zsh"
X_ZSH_DATA_HOME="$XDG_DATA_HOME/zsh"
X_ZSH_CACHE_HOME="$XDG_CACHE_HOME/zsh"
X_ZSH_STATE_HOME="$XDG_STATE_HOME/zsh"

X_ZSH_PLUGIN_HOME="$X_ZSH_CONFIG_HOME/plugins"
X_ZSH_THEME_HOME="$X_ZSH_CONFIG_HOME/themes"
X_ZSH_CORE_HOME="$X_ZSH_CONFIG_HOME"

X_ZSH_THEME_DATA_HOME="$X_ZSH_DATA_HOME/themes"
X_ZSH_PLUGIN_MANAGER_HOME="$X_ZSH_DATA_HOME/zpm"
X_ZSH_PLUGIN_DATA_HOME="$X_ZSH_DATA_HOME/plugins"

# Function to source a specific .zsh file from X_ZSH_CONFIG_HOME
# Usage: x_zsh_load "filename.zsh"
# This will attempt to source X_ZSH_CONFIG_HOME/filename.zsh
function x_zsh_load(){
    [[ -f "$X_ZSH_CONFIG_HOME/$1" ]] && source "$X_ZSH_CONFIG_HOME/$1"
}

# Function to source a specific .zsh file from X_ZSH_CONFIG_HOME
# Usage: x_zsh_require "module_name"
# This will attempt to source X_ZSH_CONFIG_HOME/module_name/module_name.zsh
function x_zsh_require(){
    local file="$X_ZSH_CONFIG_HOME/$1/$1.zsh"
    [[ -f "$file" ]] && source "$file" || echo "Warning: $file not found" >&2
}

# Function to source .zsh files in a specified directory within X_ZSH_CONFIG_HOME
# Usage:
#   x_zsh_require_dir "subdirectory_name"      : Load all .zsh files except _*.zsh files
#   x_zsh_require_dir "subdirectory_name" _    : Load all _*.zsh files
#   x_zsh_require_dir "subdirectory_name" all  : Load all .zsh files
function x_zsh_require_dir(){
    local dir="$X_ZSH_CONFIG_HOME/$1"
    local underline="$2"

    if [[ ! -d "$dir" ]]; then
        echo "Warning: Directory $dir not found" >&2
        return 1
    fi

    local files
    case "$underline" in
        _)
            files=("$dir"/_*.zsh(N))
            ;;
        all)
            files=("$dir"/*.zsh(N))
            ;;
        *)
            files=("$dir"/[^_]*.zsh(N))
            ;;
    esac

    if (( ${#files} )); then
        for file in "${files[@]}"; do
            source "$file"
        done
    fi
    # Note: If no matching .zsh files are found, the function silently does nothing
}

# Function to load user-specific Zsh configurations
# Usage:
#   load_user          - Load all user configs except plugin.zsh, theme.zsh, and _*.zsh
#   load_user plugin   - Load only plugin.zsh
#   load_user theme    - Load only theme.zsh
#   load_user _        - Load all _*.zsh files
function x_zsh_load_user() {
    local user_dir="$X_ZSH_CONFIG_HOME/user"
    
    # Check if the user directory exists
    # if [[ -d "$user_dir" ]]; then
    # else
    #     echo "Warning: User directory $user_dir not found" >&2
    #     return 1
    # fi

    case "$1" in
        _)
            # Load all _*.zsh files
            local files=("$user_dir"/_*.zsh(N))
            for file in "${files[@]}"; do
                source "$file"
            done
            ;;
        plugin)
            # Load only plugin.zsh if it exists
            [[ -f "$user_dir/plugin.zsh" ]] && source "$user_dir/plugin.zsh"
            ;;
        theme)
            # Load only theme.zsh if it exists
            [[ -f "$user_dir/theme.zsh" ]] && source "$user_dir/theme.zsh"
            ;;
        *)
            # Load all .zsh files except plugin.zsh, theme.zsh, and _*.zsh
            local files=("$user_dir"/[^_]*.zsh(N))
            for file in "${files[@]}"; do
                if [[ "$(basename "$file")" != "plugin.zsh" && "$(basename "$file")" != "theme.zsh" ]]; then
                    source "$file"
                fi
            done
            ;;
    esac
}

# Function to load a specific Zsh plugin manager
# Usage: x_zsh_load_plugin_manager "plugin_manager_name"
function x_zsh_load_plugin_manager() {
    local plugin_manager="$1"
    local plugin_manager_path="$X_ZSH_PLUGIN_HOME/zpm/$plugin_manager/$plugin_manager.zsh"

    if [[ -d "$X_ZSH_PLUGIN_HOME/zpm/$plugin_manager" ]]; then
        source "$plugin_manager_path"
    else
        echo "You don't have this plugin manager: $plugin_manager" >&2
        return 1
    fi

    # plugin config
    source "$X_ZSH_PLUGIN_HOME/configs.zsh"

    # load user
    x_zsh_load_user plugin
}

# Function to load a specific Zsh theme
# Usage: x_zsh_load_theme "theme_name"
function x_zsh_load_theme() {
    local theme_name="$1"
    local theme_file="${theme_name}.zsh-theme"
    local theme_config_home="$X_ZSH_THEME_HOME/$theme_name/$theme_file"
    local theme_data_home="$X_ZSH_THEME_DATA_HOME/$theme_name/$theme_file"

    if [[ -r "$theme_config_home" ]]; then
        source "$theme_config_home"
    elif [[ -r "$theme_data_home" ]]; then
        source "$theme_data_home"
    else
        echo "Can't find theme: $theme_name" >&2
        return 1
    fi

    # load user
    x_zsh_load_user theme
}

# Function to set directory colors
# TODO:
#   rename .dir_colors to .dircolors
#   error command not found gdiroclors
function x_zsh_set_dir_colors() {
    local dircolors_path="$1"

    # Check if the .dircolors file exists and is readable
    if [[ -r "$dircolors_path" ]]; then
        # Use different commands for macOS (Darwin) and other systems
        if [[ "$MY_OS" == "Darwin" ]]; then
            # On macOS, use gdircolors (usually installed via GNU coreutils)
            eval $(gdircolors "$dircolors_path")
        else
            # On other systems (like Linux), use the standard dircolors command
            eval $(dircolors -b "$dircolors_path")
        fi

        # If LS_COLORS is set (indicating successful color parsing)
        if [[ -n "$LS_COLORS" ]]; then
            # Apply the colors to zsh completion
            # This makes the completion menu use the same colors as ls
            zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
        fi
    else
        echo "Warning: $dircolors_path not found or not readable." >&2
    fi
}


# TODO: unverified
# Function to determine OS and distribution
function determine_os_and_distro() {
    if [[ "$(uname)" == "Darwin" ]]; then
        MY_OS="Darwin"
        MY_DISTRO="macOS"
    elif [[ "$(uname)" == "Linux" ]]; then
        if [[ -n "$(uname -a | grep -i "microsoft")" ]]; then
            MY_OS="WSL"
            MY_DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
        else
            MY_OS="Linux"
            MY_DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
        fi
    else
        MY_OS="Unknown"
        MY_DISTRO="Unknown"
    fi

    export MY_OS
    export MY_DISTRO
}

# TODO: unverified
# Function to determine OS and distribution
# determine_os_and_distro() {
#   if [[ "$(uname)" == "Darwin" ]]; then
#     MY_OS="Darwin"
#     MY_DISTRO="$(sw_vers -productName)"  # macOS
#     # DISTRO_VERSION=$(sw_vers -productVersion)
#   elif [[ -f /proc/version ]] && grep -q "Microsoft" /proc/version; then
#     MY_OS="WSL"
#     MY_DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
#   elif [[ "$(uname)" == "Linux" ]]; then
#     MY_OS="Linux"
#     if [[ -f /etc/os-release ]]; then
#       . /etc/os-release
#       MY_DISTRO="$NAME $VERSION"
#     elif command -v lsb_release > /dev/null 2>&1; then
#       MY_DISTRO="$(lsb_release -d | cut -f2)"
#     elif [[ -f /etc/lsb-release ]]; then
#       . /etc/lsb-release
#       MY_DISTRO="$DISTRIB_DESCRIPTION"
#     elif [[ -f /etc/debian_version ]]; then
#       MY_DISTRO="Debian $(cat /etc/debian_version)"
#     elif [[ -f /etc/redhat-release ]]; then
#       MY_DISTRO="$(cat /etc/redhat-release)"
#     elif [[ -f /etc/centos-release ]]; then
#       MY_DISTRO="$(cat /etc/centos-release)"
#     elif [[ -f /etc/fedora-release ]]; then
#       MY_DISTRO="$(cat /etc/fedora-release)"
#     elif [[ -f /etc/SuSE-release ]]; then
#       MY_DISTRO="$(cat /etc/SuSE-release)"
#     elif [[ -f /etc/alpine-release ]]; then
#       MY_DISTRO="Alpine $(cat /etc/alpine-release)"
#     else
#       MY_DISTRO="Unknown"
#     fi
#   else
#     MY_OS="Unknown"
#     MY_DISTRO="Unknown"
#   fi
# }


# Download from github
#
# args:
#   - $1: git url
#   - $2: target path (target parent dir)
#   - $3: name
function x_use(){
    if [[ ! -d "$2" ]]
    then
        print -P "%F{243}▓▒░ %F{249}Installing …%f"
        if command git clone --depth 1 "https://github.com/$1.git" "$2"; then
            print -P "%F{243}▓▒░ %F{67}Installation successful.%f"
        else
            print -P "%F{124}▓▒░ The clone has failed.%f"
        fi
    fi
}

# Function to update a git repo
# Usage: x_update "update_path" "current_directory"
# --------
# https://stackoverflow.com/a/36800741
function x_update(){
    local dir="$1"
    local original_dir="$2"
    cd "$dir" || return 1
    local repo_url=$(git config --get remote.origin.url)

    echo "Updating Repo: $dir with url: $repo_url"
    echo "Starting update in $PWD"

    local main_branch="master"
    local current_branch=$(git rev-parse --abbrev-ref HEAD)

    # update the repo, then stash any local changes
    echo -e "\ncalling: git fetch --all && git stash"
    (git fetch --all && git stash)

    # switch to master/trunk branch and rebase it, then switch back to original branch
    if [[ "$current_branch" != "$main_branch" ]]; then
        echo -e "\ncalling: git checkout $main_branch && git rebase && git checkout $current_branch"
        (git checkout $main_branch && git rebase && git checkout $current_branch)
    fi

    # rebase the original branch and then stash pop back to original state
    echo -e "\ncalling: git rebase && git stash pop on branch: $current_branch"
    (git rebase && git stash pop ) 

    # update submodule
    echo -e "\ncalling: git submodule update --recursive --init"
    git submodule update --recursive --init

    #switch back to the starting directory
    cd $original_dir
    echo ""
}

# TODO:DotUpdate
# ---------
function _DotUpdate(){
    echo "[[ Updating Repo ]]"
    x_update "$DOT_HOME" "$(pwd)"

    echo "[[ Updating Dotfiles ]]"
    "$DOT_HOME/__x__/init.sh" --silent

    echo ""
    echo "[[ Reloading ]]"
    echo -e "\ncalling: exec \$SHELL"
    exec $SHELL
}

# Unset all functions
function x_unset_functions() {
    unset -f x_zsh_load
    unset -f x_zsh_require
    unset -f x_zsh_require_dir
    unset -f x_zsh_load_user
    unset -f x_zsh_load_plugin_manager
    unset -f x_zsh_load_theme
    unset -f x_zsh_set_dir_colors
    unset -f determine_os_and_distro
    unset -f x_unset_functions
    unset _is_x_zsh_func
}