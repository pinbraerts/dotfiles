[ -f /etc/bashrc ] && source /etc/bashrc

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
export RUSTC_WRAPPER=sccache
export PKG_CONFIG_PATH=/usr/local/lib64/pkgconfig
export LD_LIBRARY_PATH=/usr/local/lib64
source "$HOME/.cargo/env"

[ -f ${XDG_CONFIG_DIR:-$HOME/.config}/bash/path.sh ] && . ${XDG_CONFIG_DIR:-$HOME/.config}/bash/path.sh
[ -f ${XDG_CONFIG_DIR:-$HOME/.config}/aliases.sh   ] && . ${XDG_CONFIG_DIR:-$HOME/.config}/aliases.sh
[[ $- != *i* ]] && return
set -o vi
[ -f ${XDG_CONFIG_DIR:-$HOME/.config}/bash/prompt.sh ] && . ${XDG_CONFIG_DIR:-$HOME/.config}/bash/prompt.sh

[ -f ${HOME}/.dircolors ] && source ${HOME}/.dircolors
[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
eval "$(zoxide init bash)"
