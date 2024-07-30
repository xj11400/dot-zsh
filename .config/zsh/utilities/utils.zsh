#!/bin/zsh
#
# functions/utils.zsh
#

# repalce
# =======
x_replace() {
    if [[ "$MY_OS"=="Darwin" ]];then
        sed -i "" "s+$1+$2+g" `grep -rl $1 $3`
    else
        sed -i "s+$1+$2+g" `grep -rl $1 $3`
    fi
}
