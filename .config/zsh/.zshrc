#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

setopt extended_glob # Needed for file modification glob modifiers with coreutils setup

# Load functions
# ===============

# load x_zsh functions
source $ZDOTDIR/x.zsh

# autoload functions
ZFUNCDIR=${ZFUNCDIR:-$ZDOTDIR/functions}
fpath=($ZFUNCDIR $fpath)
autoload -Uz $fpath[1]/*(:t)

# load custom functions
x_zsh_load_user _

# determin os and distro
determine_os_and_distro

# load utilities
x_zsh_require_dir utilities all

# Load Configs
# ============
x_zsh_load configs.zsh
x_zsh_load aliases.zsh

# platform config
x_zsh_load platforms/${MY_OS}.zsh

# programs
x_zsh_require_dir programs all

# load user configs
x_zsh_load_user

# plugin
export X_ZSH_PLUGIN_MANAGER=${X_ZSH_PLUGIN_MANAGER:-antidote}
x_zsh_load_plugin_manager "$X_ZSH_PLUGIN_MANAGER"

# theme
export X_ZSH_THEME=${X_ZSH_THEME:-powerlevel10k}
x_zsh_load_theme "$X_ZSH_THEME"

# .dircolors
x_zsh_set_dir_colors "$X_ZSH_THEME_HOME/.dir_colors"

# Unset Functions
# ===============
x_unset_functions

unsetopt extended_glob # `setopt extended_glob` makes `git reset --soft HEAD^` not work with `^`

