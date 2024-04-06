autoload -U +X compinit && compinit -d $ZSH_COMPDUMP
zstyle ':completion:*' verbose yes
zstyle ':completion:*' completer _extensions _complete _approximate
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path $ZSH_COMPDUMP
zstyle ':completion:*' menu select
zstyle ':completion:*' complete-options true
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}

eval "$(${MAMBA_EXE} shell hook -s zsh -p $MAMBA_ROOT_PREFIX)"
[ -d .venv ] && micromamba activate -p "$(pwd)/.venv"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
