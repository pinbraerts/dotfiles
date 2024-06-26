which >/dev/null 2>&1 bat && alias cat=bat
if which >/dev/null 2>&1 exa; then
	alias ls=exa
else
	alias ls="ls --color=auto"
fi
alias ll="ls -ll"
alias la="ls -la"
alias ccache=sccache
which >/dev/null 2>&1 make && alias m=make
which >/dev/null 2>&1 rg && alias grep=rg
which >/dev/null 2>&1 tree-sitter && alias ts=tree-sitter
which >/dev/null 2>&1 micromamba && alias mm=micromamba
[ -n $VISUAL ] && alias v=$VISUAL
[ -n $EDITOR ] && alias e=$EDITOR
