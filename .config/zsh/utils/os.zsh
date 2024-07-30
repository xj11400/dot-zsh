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

# if [[ "$(uname)" == "Darwin" ]]; then
#     # For Mac OS
#     export MY_OS="Darwin"
# elif [[ "$(uname)" == "Linux" ]];then
#     # For Linux
#     export MY_OS="Linux"
#     if [[ "$(uname -a | grep "WSL")" ]]; then
#         # For Linux
#         export MY_DISTRO="WSL"
#     fi
# else
#     export MY_OS="Linux"
# fi

# echo $MY_OS
# Function to determine OS and distribution
determine_os_and_distro() {
    if [[ "$(uname)" == "Darwin" ]]; then
        MY_OS="Darwin"
        MY_DISTRO="macOS"
    elif [[ "$(uname)" == "Linux" ]]; then
        if [[ -n "$(uname -a | grep -i "microsoft")" ]]; then
            MY_OS="WSL"
            MY_DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
        else
            MY_OS="Linux"
            MY_DISTRO=$(awk -F= '/^ID=/{print $2}' /etc/os-release | tr -d '"')
        fi
    else
        MY_OS="Unknown"
        MY_DISTRO="Unknown"
    fi

    export MY_OS
    export MY_DISTRO
}

# Call the function to set MY_OS and MY_DISTRO
determine_os_and_distro


# GPT
# check_os() {
#   if [[ "$(uname)" == "Darwin" ]]; then
#     MY_OS="Darwin"
#     MY_DISTRO="$(sw_vers -productName)"  # macOS
#     # DISTRO_VERSION=$(sw_vers -productVersion)
#   elif [[ -f /proc/version ]] && grep -q "Microsoft" /proc/version; then
#     MY_OS="WSL"
#     MY_DISTRO="WSL"
#   elif [[ "$(uname)" == "Linux" ]]; then
#     MY_OS="Linux"
#     if [[ -f /etc/os-release ]]; then
#       . /etc/os-release
#       MY_DISTRO="$NAME $VERSION"
#     elif command -v lsb_release > /dev/null 2>&1; then
#       MY_DISTRO="$(lsb_release -d | cut -f2)"
#     elif [[ -f /etc/lsb-release ]]; then
#       . /etc/lsb-release
#       MY_DISTRO="$DISTRIB_DESCRIPTION"
#     elif [[ -f /etc/debian_version ]]; then
#       MY_DISTRO="Debian $(cat /etc/debian_version)"
#     elif [[ -f /etc/redhat-release ]]; then
#       MY_DISTRO="$(cat /etc/redhat-release)"
#     elif [[ -f /etc/centos-release ]]; then
#       MY_DISTRO="$(cat /etc/centos-release)"
#     elif [[ -f /etc/fedora-release ]]; then
#       MY_DISTRO="$(cat /etc/fedora-release)"
#     elif [[ -f /etc/SuSE-release ]]; then
#       MY_DISTRO="$(cat /etc/SuSE-release)"
#     elif [[ -f /etc/alpine-release ]]; then
#       MY_DISTRO="Alpine $(cat /etc/alpine-release)"
#     else
#       MY_DISTRO="Unknown"
#     fi
#   else
#     MY_OS="Unknown"
#     MY_DISTRO="Unknown"
#   fi
# }

# check_os
