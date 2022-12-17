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
export VIMINIT='source $MYVIMRC'
export MYVIMRC='$XDG_CONFIG_HOME/vim/vimrc'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# less
export LESSHISTFILE="$XDG_CACHE_HOME/less/lesshst"

# wget
#export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"
alias wget='wget --hsts-file="$XDG_CACHE_HOME/wget-hsts"'

# python
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/python_startup.py"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"

# config
# ======

# tmux
bindkey -e
alias tmux="tmux -2"



# source 
