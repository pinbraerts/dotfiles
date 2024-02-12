[ -f /etc/bashrc ] && source /etc/bashrc

export INPUTRC=~/.config/.inputrc
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

[ -f ~/.config/bash/path.sh ] && . ~/.config/bash/path.sh
[[ $- != *i* ]] && return
# [ -f ~/.local/share/blesh/ble.sh ] && . ~/.local/share/blesh/ble.sh --noattach
[ -f ~/.config/bash/setup.sh ] && . ~/.config/bash/setup.sh

[ -f /usr/share/bash-completion/bash_completion ] && . /usr/share/bash-completion/bash_completion
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash
eval "$(zoxide init bash)"

# [[ ${BLE_VERSION-} ]] && ble-attach
