shell=
case $(ls -l /proc/$$/exe) in
	*bash)
		shell=bash
		;;
	*zsh)
		shell=zsh
		;;
	*fish)
		shell=fish
		;;
	*)
		return
		;;
esac

eval "$(zoxide init --cmd cd $shell)" 2>/dev/null
eval "$(joshuto completions $shell)" 2>/dev/null
eval "$(fzf --$shell)" 2>/dev/null
eval "$(\"$MAMBA_EXE\" shell hook --shell $shell --root-prefix \"$MAMBA_ROOT_PREFIX\" 2> /dev/null)" 2>/dev/null
