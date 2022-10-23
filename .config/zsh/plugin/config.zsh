# --------------
# zsh plugin
# --------------

# zsh-syntax-highlighting
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[command]='fg=111'
ZSH_HIGHLIGHT_STYLES[alias]='fg=73'

# zsh-autosuggestions
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=238'

# zsh-autocomplete
zstyle ':autocomplete:*' default-context history-incremental-search-backward
zstyle ':autocomplete:history-search:*' list-lines 16  # int

# fast-syntax-highlighting
# https://z.digitalclouds.dev/ecosystem/plugins/f-sy-h
FAST_WORK_DIR=$HOME/.config/fsh

# fzf-tab
#zstyle ":completion:*" matcher-list \
#  'b:=*' \
#  "m:{a-zA-Z}={A-Za-z}" \
#  "r:|[._-]=* r:|=*" \
#  "l:|=* r:|=*"
#
#zstyle ":completion:*:git-checkout:*" sort false
#zstyle ':completion:*' group-name ''
#zstyle ':completion:*:descriptions' format '[%d]'
#zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
#zstyle ':fzf-tab:*' single-group color header
#zstyle ':fzf-tab:*' group-colors $FZF_TAB_GROUP_COLORS
#zstyle ':fzf-tab:complete:cd:*' fzf-preview 'exa -1 --color=always $realpath'
#zstyle ':fzf-tab:complete:_zlua:*' query-string input
#zstyle ':completion:*:*:git:*' script ~/.git-completion

# --------------
# other plugin
# --------------

# fzf
# replace by wfxr/forgit
#alias gco='git checkout $(git branch | fzf --cycle --border --ansi)'
#alias gadd="git status --short | fzf --multi --color=dark --cycle --border --ansi --preview-window=up:70% --preview=\"git diff --color {+2}\" | awk '{print \$2}'  | xargs git add"

# fzf-scripts
# https://github.com/bturrubiates/fzf-scripts
alias gsh="~/.local/share/fzf-scripts/git-stash-explore"

