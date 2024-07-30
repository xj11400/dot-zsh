
# Homebrew
# Check if the Homebrew executable exists and is executable (-x)
if [ -x "/opt/homebrew/bin/brew" ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi