setopt autocd
setopt interactive_comments
setopt inc_append_history
setopt histignorealldups
if test -n "${TRACE+x}"; then
	zmodload zsh/zprof
fi

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

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=true

source $ZDOTDIR/plugins.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/prompt.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/activate.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/tools.sh

zvm_after_init() {
	bindkey '^Y' autosuggest-accept
	zle     -N            fzf-history-widget
	bindkey -M emacs '^R' fzf-history-widget
	bindkey -M vicmd '^R' fzf-history-widget
	bindkey -M viins '^R' fzf-history-widget
}

if test -n "${TRACE+x}"; then
	zprof
fi
