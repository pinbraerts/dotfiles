source $HOME/.env

[[ $- != *i* ]] && return
set -o vi
source ${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/prompt.sh

source /usr/share/bash-completion/bash_completion
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
eval "$(zoxide init --cmd cd bash)"
eval "$(joshuto completions bash)"
. "$HOME/.cargo/env"
