# Antidote's home folder
export ANTIDOTE_HOME=$X_ZSH_PLUGIN_MANAGER_HOME/antidote

# clone Antidote
x_use "mattmc3/antidote" $ANTIDOTE_HOME/antidote

# Set the root name of the plugins files (.txt and .zsh) antidote will use.
zsh_plugins=${ZDOTDIR:-$HOME/.config/zsh}/plugins/zpm/antidote/.zsh_plugins

# Ensure the .zsh_plugins.txt file exists so you can add plugins.
[[ -f ${zsh_plugins}.txt ]] || touch ${zsh_plugins}.txt

# Lazy-load antidote from its functions directory.
fpath=($ANTIDOTE_HOME/antidote/functions $fpath)
autoload -Uz antidote

# Lazy-load antidote and generate the static load file only when needed
if [[ ! $ANTIDOTE_HOME/zsh_plugins.zsh -nt ${zsh_plugins}.txt ]]; then
  (
    source $ANTIDOTE_HOME/antidote/antidote.zsh
    antidote bundle <${zsh_plugins}.txt >$ANTIDOTE_HOME/zsh_plugins.zsh
  )
fi
source $ANTIDOTE_HOME/zsh_plugins.zsh

