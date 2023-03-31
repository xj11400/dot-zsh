#
# programs
# ############################################################

# alias
# =====
alias ra='$(command -v ranger)'
alias lgit='lazygit'
alias ldocker='lazydocker'
alias nnn='nnn -H'

# XDG path
# ========

# vim
export MYVIMRC='$XDG_CONFIG_HOME/vim/vimrc'
export VIMINIT='let $MYVIMRC=!has("nvim")?"$XDG_CONFIG_HOME/vim/vimrc":"$XDG_CONFIG_HOME/nvim/init.lua" | so $MYVIMRC'

# less
export LESSHISTFILE="$XDG_CACHE_HOME/less/lesshst"

# wget
#export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# config
# ======

# tmux
bindkey -e
alias tmux="tmux -2"



# source 
