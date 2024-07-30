# check starship exist
# x_use "starship/starship" $X_ZSH_THEME_DATA_HOME/starship

if ! command -v starship &> /dev/null; then
    curl -sS https://starship.rs/install.sh | sh
fi

export STARSHIP_CONFIG=$X_ZSH_THEME_HOME/starship/starship.toml

export STARSHIP_CACHE=$X_ZSH_CACHE_HOME/starship/cache

eval "$(starship init zsh)"
