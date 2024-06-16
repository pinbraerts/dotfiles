source $HOME/.env

[[ $- != *i* ]] && return
set -o vi
source ${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/prompt.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/activate.sh

[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion || true
[ -x zoxide ] && eval "$(zoxide init --cmd cd bash)" || true
[ -x joshuto ] && eval "$(joshuto completions bash)" || true
[ -x "$MAMBA_EXE" ] && eval "$(\"$MAMBA_EXE\" shell hook --shell bash --root-prefix \"$MAMBA_ROOT_PREFIX\" 2> /dev/null)" || true
[ -f ~/.fzf.bash ] && source ~/.fzf.bash || true
