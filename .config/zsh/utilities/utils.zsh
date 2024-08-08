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

# Function to delete all files recursively under the given directory
# Usage: delete_files "file_name" <directory>
_delete_files() {
    local file_name="$1"
    local dir="${2:-.}"  # Use current directory if no directory argument is provided
    if [ -d "$dir" ]; then
        find "$dir" -type f -name "$file_name" -print -delete | while read -r file; do
            echo " > Deleted: $file"
        done
        echo "Finished deleting $file_name files under $dir"
    else
        echo "Error: $dir is not a valid directory"
    fi
}
