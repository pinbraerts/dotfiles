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
which >/dev/null 2>&1 sccache && export RUSTC_WRAPPER=sccache
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
[ -f /usr/share/fzf/key-bindings.bash ] && . /usr/share/fzf/key-bindings.bash
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
which >/dev/null 2>&1 zoxide  && eval "$(zoxide init --cmd cd bash)"
which >/dev/null 2>&1 joshuto && eval "$(joshuto completions bash)"
