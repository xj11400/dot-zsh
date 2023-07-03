#
# language
# ############################################################

# python
# ======
PATH=$XDG_DATA_HOME/python/bin:$PATH
export PYTHONSTARTUP="$XDG_CONFIG_HOME/python/python_startup.py"
export PYTHONPYCACHEPREFIX="$XDG_CACHE_HOME/python"
export PYTHONUSERBASE="$XDG_DATA_HOME/python"
export PYTHONHISTFILE="$XDG_CACHE_HOME/python/python_history"

if [ "$(command -v pyenv)" ]; then
    export PYENV_ROOT="$XDG_DATA_HOME/pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init -)"
fi

# go
# ==
export GOPATH="$XDG_DATA_HOME"/go
export GOMODCACHE="$XDG_CACHE_HOME"/go/mod

# rust
# ====
export RUSTUP_HOME="$XDG_DATA_HOME"/rustup
