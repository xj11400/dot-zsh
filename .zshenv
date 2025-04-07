#!/bin/zsh
#
# .zshenv - Zsh environment file, loaded always.
#

# XDG Paths
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}
export XDG_SRC_HOME=${XDG_SRC_HOME:-$HOME/.local/src}

# ZSH
export ZDOTDIR=${ZDOTDIR:-$XDG_CONFIG_HOME/zsh}
export DOT_HOME=$HOME/.dotfiles

# You can use .zprofile to set environment vars for non-login, non-interactive shells.
if [[ ( "$SHLVL" -eq 1 && ! -o LOGIN ) && -s "${ZDOTDIR:-$HOME}/.zprofile" ]]; then
  source "${ZDOTDIR:-$HOME}/.zprofile"
fi

# PATH
export PATH=$HOME/.local/bin:/usr/local/bin:$PATH

