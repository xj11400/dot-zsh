#
#
#

# load theme
# ==========

load_theme() {
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
    # load_user plugin
}

# Call the function with $X_ZSH_THEME
load_theme "$X_ZSH_THEME"

# dir colors
# ==========

# Function to set directory colors
set_dir_colors() {
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

# Call the function with the path to .dircolors
# set_dir_colors "$X_ZSH_THEME_HOME/.dircolors"
# TODO:
# rename .dir_colors to .dircolors
# error command not found gdiroclors