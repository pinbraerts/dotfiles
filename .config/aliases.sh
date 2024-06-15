alias_exists() {
	target=$1
	shift
	which >/dev/null 2>&1 $1 && alias $target="$*"
}
alias_exists cat bat
alias_exists ls exa || alias ls="ls --color=auto"
alias ll="ls -ll"
alias la="ls -la"
alias_exists cp rsync --info=progress2 --info=name0
alias_exists ccache sccache
alias_exists m make
alias_exists grep rg
alias_exists ts tree-sitter
alias_exists mm micromamba
alias_exists sv systemctl
[ -n $VISUAL ] && alias v=$VISUAL
[ -n $EDITOR ] && alias e=$EDITOR
