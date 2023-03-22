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
# https://stackoverflow.com/a/36800741
function x_update(){
    local dir="$1"
    local original_dir="$2"
    cd $dir # switch to the git repo
    repo_url=$(git config --get remote.origin.url)

    echo "Updating Repo: $dir with url: $repo_url"
    echo "Starting update in $PWD"

    main_branch="master"

    # update the repo, then stash any local changes
    echo -e "\ncalling: git fetch --all && git stash"
    (git fetch --all && git stash)
    current_branch=$(git rev-parse --abbrev-ref HEAD)

    # switch to master/trunk branch and rebase it, then switch back to original branch
    if [ $current_branch != $main_branch ]; then
        echo -e "\ncalling: git checkout $main_branch && git rebase && git checkout $current_branch"
        (git checkout $main_branch && git rebase && git checkout $current_branch)
    fi

    # rebase the original branch and then stash pop back to original state
    echo -e "\ncalling: git rebase && git stash pop on branch: $current_branch"
    (git rebase && git stash pop ) 

    # update submodule
    echo -e "\ncalling: git submodule update --recursive --init"
    git submodule update --recursive --init

    #switch back to the starting directory
    cd $original_dir
    echo ""
}

# DotUpdate
# ---------
function _DotUpdate(){
    echo "[[ Updating Repo ]]"
    x_update $DOT_HOME $(pwd)

    echo "[[ Updating Dotfiles ]]"
    $DOT_HOME/__x__/init.sh --silent

    echo ""
    echo "[[ Reloading ]]"
    echo -e "\ncalling: exec \$SHELL"
    exec $SHELL
}
