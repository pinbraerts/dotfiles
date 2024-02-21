which >/dev/null 2>&1 bat && alias cat=bat
if which >/dev/null 2>&1 exa; then
	alias ls=exa
else
	alias ls="ls --color=auto"
fi
alias ll="ls -ll"
alias la="ls -la"
rdp() {
	xfreerdp $@ -grab-keyboard /kbd-remap:0x1d=0x3a,0x3a=0x1d 
	return $?
}
which >/dev/null 2>&1 make && alias m=make
which >/dev/null 2>&1 rg && alias grep=rg
[ -n $VISUAL ] && alias v=$VISUAL
[ -n $EDITOR ] && alias e=$EDITOR
