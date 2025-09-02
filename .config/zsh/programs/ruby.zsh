# GEM
if [ "$(command -v gem)" ]; then
    export GEM_HOME="${XDG_DATA_HOME:-~/.local/share}/gem"
    export PATH=$GEM_HOME/bin:$PATH
fi

# RBENV
if [ "$(command -v rbenv)" ]; then
    export RBENV_ROOT="${XDG_DATA_HOME:-~/.local/share}/rbenv"
    eval "$(rbenv init - --no-rehash zsh)"
fi

# bundler
if [ "$(command -v bundle)" ]; then
    export BUNDLE_USER_CACHE=$XDG_CACHE_HOME/bundle
    export BUNDLE_USER_CONFIG=$XDG_CONFIG_HOME/bundle/config
    export BUNDLE_USER_PLUGIN=$XDG_DATA_HOME/bundle
fi
