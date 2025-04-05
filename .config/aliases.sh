alias_exists() {
	target=$1
	shift
	command -v >/dev/null 2>&1 $1 && alias $target="$*"
}
alias_exists cat bat
alias_exists ls exa || alias ls="ls --color=auto"
alias ll="ls -ll"
alias la="ls -la"
alias_exists cp rsync --info=progress2 --info=name0
alias_exists ccache sccache
alias_exists xclip xclip -selection clipboard
alias_exists m make
alias_exists grep rg
alias_exists gc git commit
alias_exists gs git status
alias_exists gl git log --all --decorate --oneline --graph
alias_exists gcm git commit --message
alias_exists gpl git pull --rebase
alias_exists gp git push
alias_exists gP git push --force
alias_exists gf git fetch
alias_exists gF git fetch --all --prune
alias_exists gr git rebase
alias_exists gri git rebase --interactive
alias_exists gra git rebase --abort
alias_exists grc git rebase --continue
alias_exists go git checkout
alias_exists g. git add .
alias_exists ts tree-sitter
alias_exists mm micromamba
alias_exists sv systemctl
alias_exists sudo doas
alias mc="mc --nosubshell"
[ -n $VISUAL ] && alias v=$VISUAL
[ -n $EDITOR ] && alias e=$EDITOR
