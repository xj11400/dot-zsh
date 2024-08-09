# check is powerlevel10k exist
x_use "romkatv/powerlevel10k" "$X_ZSH_THEME_DATA_HOME/powerlevel10k"

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# use powerlevel10k
source $X_ZSH_THEME_DATA_HOME/powerlevel10k/powerlevel10k.zsh-theme

# use robbyrussell theme
#source $X_ZSH_THEME_DATA_HOME/powerlevel10k/config/p10k-robbyrussell.zsh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f $X_ZSH_THEME_HOME/powerlevel10k/.p10k.zsh ]] || source $X_ZSH_THEME_HOME/powerlevel10k/.p10k.zsh

autoload -Uz promptinit && promptinit
