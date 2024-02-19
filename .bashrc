function safe_source {
	[ -f $1 ] && source $1
}
safe_source /etc/bashrc
safe_source $HOME/.env
safe_source ${XDG_CONFIG_HOME:-$HOME/.config}/bash/path.sh

[[ $- != *i* ]] && return
set -o vi
safe_source ${XDG_CONFIG_HOME:-$HOME/.config}/aliases.sh
safe_source ${XDG_CONFIG_HOME:-$HOME/.config}/prompt.sh

safe_source /usr/share/bash-completion/bash_completion
safe_source /usr/share/fzf/key-bindings.bash
safe_source /usr/share/fzf/completion.bash
which >/dev/null 2>&1 zoxide  && eval "$(zoxide init --cmd cd bash)"
which >/dev/null 2>&1 joshuto && eval "$(joshuto completions bash)"
