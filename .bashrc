function safe_source {
	[ -f $1 ] && source $1
}
safe_source /etc/bashrc

export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib64
export EDITOR=nvim
export VISUAL=nvim
export HISTCONTROL=ignoreboth
export HISTSIZE=10000
export LESS_TERMCAP_mb=$'\e[31m'
export LESS_TERMCAP_md=$'\e[32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[43;34m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[33m'
which >/dev/null 2>&1 sccache && export RUSTC_WRAPPER=sccache

safe_source "$HOME/.cargo/env"
safe_source ${XDG_CONFIG_DIR:-$HOME/.config}/bash/path.sh
safe_source ${XDG_CONFIG_DIR:-$HOME/.config}/aliases.sh

[[ $- != *i* ]] && return
set -o vi
safe_source ${XDG_CONFIG_DIR:-$HOME/.config}/bash/prompt.sh

safe_source ${HOME}/.dircolors
safe_source /usr/share/bash-completion/bash_completion
safe_source /usr/share/fzf/key-bindings.bash
safe_source /usr/share/fzf/completion.bash
which >/dev/null 2>&1 zoxide  && eval "$(zoxide init --cmd cd bash)"
which >/dev/null 2>&1 joshuto && eval "$(joshuto completions bash)"
