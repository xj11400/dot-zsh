#
# js
# ############################################################

# nodejs
# ======
export NODE_REPL_HISTORY="$XDG_DATA_HOME"/node_repl_history

# npm
# ===
export NPM_CONFIG_USERCONFIG=$XDG_CONFIG_HOME/npm/npmrc

# nvm
# ===
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# bun
# ===
if [ "$(command -v bun)" ]; then
    export PATH="$XDG_CACHE_HOME/.bun/bin:$PATH"
fi
