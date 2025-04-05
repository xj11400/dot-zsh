#!/bin/zsh
#
# aliases.zsh : aliases
#

# dotfiles directory
alias dot='cd ~/.dotfiles'
alias nvzsh="nvim $XDG_CONFIG_HOME/zsh"
alias nvtmux="nvim $XDG_CONFIG_HOME/tmux"
alias nvnvim="nvim $XDG_CONFIG_HOME/nvim"
alias nvnix="nvim $HOME/.dotfiles/nix-config"

# gls
# function -coreutils-alias-setup is from belak/zsh-utils:utility
# https://github.com/belak/zsh-utils/blob/main/utility/utility.plugin.zsh#L18

# dircolors is a surprisingly good way to detect GNU vs BSD coreutils
if (( $+commands[gdircolors] )); then
    alias gls='gls --group-directories-first --color=auto'
    alias gll='gls -alh'
fi

# ls
if [[ "$MY_OS" == "Darwin" ]];then
    export CLICOLOR='true'
    alias ls="ls -G"
else
    alias ls="ls --color=auto"
fi

# command
alias ll="ls -alh"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'

# from belak/zsh-utils:utility
# https://github.com/belak/zsh-utils/blob/main/utility/utility.plugin.zsh
# macOS utils everywhere
if [[ "$OSTYPE" == darwin* ]]; then
  alias o='open'
elif [[ "$OSTYPE" == cygwin* ]]; then
  alias o='cygstart'
  alias pbcopy='tee > /dev/clipboard'
  alias pbpaste='cat /dev/clipboard'
elif [[ "$OSTYPE" == linux-android ]]; then
  alias o='termux-open'
  alias pbcopy='termux-clipboard-set'
  alias pbpaste='termux-clipboard-get'
else
  alias o='xdg-open'

  if [[ -n $DISPLAY ]]; then
    if (( $+commands[xclip] )); then
      alias pbcopy='xclip -selection clipboard -in'
      alias pbpaste='xclip -selection clipboard -out'
    elif (( $+commands[xsel] )); then
      alias pbcopy='xsel --clipboard --input'
      alias pbpaste='xsel --clipboard --output'
    fi
  else
    if (( $+commands[wl-copy] && $+commands[wl-paste] )); then
      alias pbcopy='wl-copy'
      alias pbpaste='wl-paste'
    fi
  fi
fi

alias pbc='pbcopy'
alias pbp='pbpaste'