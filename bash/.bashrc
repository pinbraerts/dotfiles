#!/bin/bash

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Source aliases
if [ -f ~/.config/aliases.sh ]; then
    . ~/.config/aliases.sh
fi

set -o vi

function prompt() {
    echo -ne "\[\033[33m\]\ue0b6\[\033[43;01;37m\]\w"
    branch=$(git branch --show-current 2>/dev/null)
    if [ -n "$branch" ]; then
        echo -ne " \[\033[47;01;33m\] $branch\[\033[0;37m\]"
    else
        echo -ne "\[\033[0;33m\]"
    fi
    echo -ne "\ue0b4\[\033[0m\] "
}

function update_prompt() {
    PS1=$(prompt)
}

if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]; then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
if ! [[ "$PATH" =~ "$HOME/opt/lua-language-server/bin" ]]; then
    PATH="$HOME/opt/lua-language-server/bin:$PATH"
fi
export PATH

if ! [[ "$LD_LIBRARY_PATH" =~ "/usr/local/lib" ]]; then
    LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=10000
export PROMPT_COMMAND=update_prompt

# tools imports
. "$HOME/.cargo/env"

# >>> mamba initialize >>>
# !! Contents within this block are managed by 'mamba init' !!
export MAMBA_EXE='/home/pinbraerts/bin/micromamba';
export MAMBA_ROOT_PREFIX='/home/pinbraerts/micromamba';
__mamba_setup="$("$MAMBA_EXE" shell hook --shell bash --root-prefix "$MAMBA_ROOT_PREFIX" 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__mamba_setup"
else
    alias micromamba="$MAMBA_EXE"  # Fallback on help from mamba activate
fi
unset __mamba_setup
# <<< mamba initialize <<<
