#
# environment.zsh
# ############################################################

# environment
# ===========

# xdg path
# --------
# .. config directory
#    - Where user-specific configurations should be written (analogous to /etc).
#    - Should default to $HOME/.config.
[[ -z "$XDG_CONFIG_HOME" ]] && export XDG_CONFIG_HOME="$HOME/.config"

# .. cache directory
#    - Where user-specific data files should be written (analogous to /usr/share).
#    - Should default to $HOME/.cache.
[[ -z "$XDG_CACHE_HOME" ]] && export XDG_CACHE_HOME="$HOME/.cache"

# .. data directory
#    - Where user-specific data files should be written (analogous to /usr/share).
#    - Should default to $HOME/.local/share.
[[ -z "$XDG_DATA_HOME" ]] && export XDG_DATA_HOME="$HOME/.local/share"

# .. state directory
#    - Where user-specific state files should be written (analogous to /var/lib).
#    - Should default to $HOME/.local/state.
[[ -z "$XDG_STATE_HOME" ]] && export XDG_STATE_HOME="$HOME/.local/state"

# .. source directory
#    - source file
#    - default to $HOME/.local/src.
[[ -z "$XDG_SRC_HOME" ]] && export XDG_SRC_HOME="$HOME/.local/src"

# variables
# ---------
[[ -z "$DOT_HOME" ]] && export DOT_HOME="$HOME/.dotfiles"

# zsh
# ---
[[ ! -d "$XDG_STATE_HOME/zsh" ]] && mkdir -p "$XDG_STATE_HOME/zsh"
[[ ! -d "$XDG_CACHE_HOME/zsh" ]] && mkdir -p "$XDG_CACHE_HOME/zsh"

# .zsh_history
export HISTFILE="$XDG_STATE_HOME/zsh/history"

# .zcompdump
[[ -z "$ZSH_COMPDUMP" ]] && export ZSH_COMPDUMP="$XDG_CACHE_HOME/zsh/zcompdump"

autoload -Uz compinit
compinit -d $ZSH_COMPDUMP

# .zcompcache
zstyle ':completion:*' cache-path $XDG_CACHE_HOME/zsh/zcompcache
