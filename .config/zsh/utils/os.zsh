# ostype

# OSTYPE
# if [[ "$OSTYPE" ==  "darwin"*  ]]; then
#     export MY_OS="Darwin"
# elif [[ "$OSTYPE" == "linux-gnu"  ]]; then
#     export MY_OS="Linux"
# else
#     export MY_OS="Linux"
# fi

# uname

if [[ "$(uname)" == "Darwin" ]]; then
    # For Mac OS
    export MY_OS="Darwin"
elif [[ "$(uname)" == "Linux" ]];then
    # For Linux
    export MY_OS="Linux"
    if [[ "$(uname -a | grep "WSL")" ]]; then
        # For Linux
        export MY_DISTRO="WSL"
    fi
else
    export MY_OS="Linux"
fi

# echo $MY_OS
