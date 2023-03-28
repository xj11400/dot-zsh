#

# repalce
# =======
x_replace() {
    sed -i "s+$1+$2+g" `grep -rl $1 $3`
}
