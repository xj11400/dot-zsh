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
export MYVIMRC='$HOME/.config/vim/vimrc'

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# config
# ======

# tmux
bindkey -e
alias tmux="tmux -2"



# source 
