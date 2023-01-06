#
# general.zsh
# ############################################################

# History config
HISTSIZE=10000
SAVEHIST=10000

# alias

## ls
if [[ "$MY_OS" == "Darwin" ]];then
    export CLICOLOR='true'
    alias ls="ls -G"
else
    alias ls="ls --color=auto"
fi

## command
alias ll="ls -alh"
alias dir='dir --color=auto'
alias vdir='vdir --color=auto'
alias grep='grep --color=auto'

#
export TERM=xterm-256color

# 
if [[ "$MY_OS" == "Darwin" ]];then
    export LC_ALL=en_US.UTF-8
fi

#
alias dot='cd ~/.dotfiles'
