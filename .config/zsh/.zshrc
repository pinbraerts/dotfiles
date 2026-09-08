setopt autocd
setopt interactive_comments
setopt inc_append_history
setopt histignorealldups
if test -n "${TRACE+x}"; then
	zmodload zsh/zprof
fi


source "$ZDOTDIR/plugins.sh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/activate.sh"
source "${XDG_CONFIG_HOME:-$HOME/.config}/tools.sh"

autoload -Uz compinit
load-completions() {
    if [[ -n "${ZSH_COMPDUMP}(#qN.mh+24)" ]]; then
        echo one
        compinit -D -d "${ZSH_COMPDUMP}"
    else
        echo two
        compinit -C -d "${ZSH_COMPDUMP}"
    fi
    zle -D load-completions
}
zle -N load-completions

zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path "$ZSH_COMPDUMP"
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

# bun completions
[ -s "/home/pinbraerts/.bun/_bun" ] && source "/home/pinbraerts/.bun/_bun"
