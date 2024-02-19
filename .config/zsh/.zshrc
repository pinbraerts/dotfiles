setopt prompt_subst
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

autoload -Uz vcs_info
zstyle ':vcs_info:*' get-revision true
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' %F{yellow}*%f'
# zstyle ':vcs_info:*' stagedstr ' %F{yellow}+%f'
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' formats ' %f%F{magenta} %b%u'
zstyle ':vcs_info:git:*' actionformats ' %f%F{magenta} %b|%a%u'

bindkey -v
export KEYTIMEOUT=1

eval "$(zoxide init --cmd cd zsh)"
eval "$(joshuto completions zsh)"

ZSH_AUTOSUGGEST_STRATEGY=(history completion)
ZSH_AUTOSUGGEST_MANUAL_REBIND=true

source ${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/prompt.sh
source $HOME/opt/zsh-vi-mode/zsh-vi-mode.zsh
source /usr/share/fzf/key-bindings.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

bindkey '^ ' autosuggest-accept

# unsetopt xtrace
# exec 2>&3 3>&-
