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
alias_exists tt ya tool tt
alias_exists tm ya tool tt make
alias_exists am arc mount ~/arcadia
alias_exists as arc status
alias_exists apr arc pr select
alias_exists ao arc checkout
alias_exists ari arc rebase --interactive
alias_exists ara arc rebase --abort
alias_exists ar arc rebase
alias_exists ac arc commit
alias_exists acm arc commit --message
alias_exists aca arc commit --amend
alias_exists ap arc push
alias_exists apl arc pull
alias_exists al arc log
alias_exists af arc fetch
alias_exists a. arc add .
[ -n $VISUAL ] && alias v=$VISUAL
[ -n $EDITOR ] && alias e=$EDITOR
