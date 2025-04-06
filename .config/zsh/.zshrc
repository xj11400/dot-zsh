#!/bin/zsh
#
# .zshrc - Zsh file loaded on interactive shell sessions.
#

# export ZDOTDIR=${ZDOTDIR:-$HOME/.config/zsh}

# clone zx
[[ -d ${ZDOTDIR:-$HOME/.config/zsh}/zx ]] ||
    git clone https://github.com/xj11400/zx-zsh.git ${ZDOTDIR:-$HOME/.config/zsh}/zx

# configs
# _zx_plugins=(
#     alias
#     config
#     color
#     platform
#     prompt
#     utility
# )
# zstyle ':zx:load' plugins $_zx_plugins

# prompt
#   - starship: zx, zx_nf ($ZDOTDIR/themes/xxx.toml)
#   - p10k: zx, snowblocks, newline ($ZDOTDIR/themes/xxx.p10k.zsh)
zstyle ':zx:load' prompt starship zx

# plugin manager
#   antidote:
#     - zsh_plugins: $ZDOTDIR/zpm/zsh_plugins
#     - plugin configs: $ZDOTDIR/zpm/configs
zstyle ':zx:load' plugin-manager antidote

# programs
zstyle ':zx:load' programs true

# user config dirs
zx_user=(
    programs
    user
)
zstyle ':zx:load' user-confd $zx_user

# source zx
source ${ZDOTDIR:-$HOME/.config/zsh}/zx/zx.zsh

# path
export PATH=$HOME/.local/share/utils:$PATH
