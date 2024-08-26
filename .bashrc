[[ $- != *i* ]] && return
set -o vi
source ${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/activate.sh
source ${XDG_CONFIG_HOME:-$HOME/.config}/tools.sh

[ -f /usr/share/bash-completion/bash_completion ] && source /usr/share/bash-completion/bash_completion || true
