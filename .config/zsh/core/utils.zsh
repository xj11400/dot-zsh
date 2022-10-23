#
# utils.zsh
# ############################################################

# function
# ========

# x_use 
# -----
# download from github
#
# args:
#   - $1: git url
#   - $2: target path (target parent dir)
#   - $3: name
function x_use(){
    if [[ ! -d "$2" ]]
    then
        print -P "%F{243}▓▒░ %F{249}Installing …%f"
        #command mkdir -p "$2/$3" #&& command chmod g-rwX "$2"
        command git clone "https://github.com/$1.git" "$2" --depth 1 && \
        print -P "%F{243}▓▒░ %F{67}Installation successful.%f" || \
        print -P "%F{124}▓▒░ The clone has failed.%f"
    fi
}

# x_update
# --------
function x_update(){
    unset -f x_use
    function x_use(){
        echo "git pull"
    }
    #source $1
}
