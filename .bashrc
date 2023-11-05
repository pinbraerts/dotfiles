export LANG='C.UTF-8'
export HISTCONTROL=ignoreboth:erasedups

set -o vi
pwln=$'\ue0b0'
PS1="\[\033[1;42;37m\] \H \[\033[0;32;44m\]$pwln\[\033[1;37m\] \w \[\033[00;34m\]$pwln\[\033[00m\] "

alias ..="cd .."
alias ...="cd ..."
alias la="ls -lA"

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:/c/Programs/GnuWin32/bin:$PATH"
fi
export PATH

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
# source /home/common/studtscm02/miniconda3/etc/profile.d/conda.sh
