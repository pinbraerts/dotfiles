setopt autocd
setopt interactive_comments
setopt inc_append_history
setopt histignorealldups
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

eval "$(zoxide init --cmd cd zsh)"
eval "$(joshuto completions zsh)"
ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=true

source $ZDOTDIR/plugins.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/prompt.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/activate.sh

zvm_after_init() {
	bindkey '^Y' autosuggest-accept
	zle     -N            fzf-history-widget
	bindkey -M emacs '^R' fzf-history-widget
	bindkey -M vicmd '^R' fzf-history-widget
	bindkey -M viins '^R' fzf-history-widget
}
# unsetopt xtrace
# exec 2>&3 3>&-
