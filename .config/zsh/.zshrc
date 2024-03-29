setopt autocd
setopt interactive_comments
setopt inc_append_history
setopt histignorealldups
export HISTFILE=${XDG_CONFIG_CACHE:-$HOME/.cache}/zsh/.history
export ZSH_COMPDUMP=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.complete
# PS4='+$EPOCHREALTIME %N:%i> '
# logfile=$(mktemp zsh_profile.XXXXXX)
# exec 3>&2 2>$logfile
# setopt xtrace

autoload -U +X compinit && compinit -d $ZSH_COMPDUMP
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_COMPDUMP
zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zmodload zsh/complist
bindkey -M menuselect h vi-backward-char
bindkey -M menuselect j vi-down-line-or-history
bindkey -M menuselect k vi-up-line-or-history
bindkey -M menuselect l vi-forward-char

bindkey -v
export KEYTIMEOUT=1

eval "$(zoxide init --cmd cd zsh)"
eval "$(joshuto completions zsh)"
eval "$(${MAMBA_EXE} shell hook -s zsh -p $MAMBA_ROOT_PREFIX)"
[ -d .env ] && micromamba activate -p "$(pwd)/.env"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=true

source $ZDOTDIR/plugins.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/prompt.sh

zvm_after_init() {
bindkey '^Y' autosuggest-accept


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
}
# unsetopt xtrace
# exec 2>&3 3>&-
