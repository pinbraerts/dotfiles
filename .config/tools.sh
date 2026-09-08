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

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - $shell)"
eval "$(starship init $shell)" 2>/dev/null
eval "$(zoxide init --cmd cd $shell)" 2>/dev/null
eval "$(fzf --$shell)" 2>/dev/null
# eval "$(\"$MAMBA_EXE\" shell hook --shell $shell --root-prefix \"$MAMBA_ROOT_PREFIX\" 2> /dev/null)" 2>/dev/null

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# The next line updates PATH for Yandex Cloud CLI.
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for Yandex Cloud CLI.
# if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

# The next line updates PATH for Yandex Cloud Private CLI.
if [ -f "$HOME/ycp/path.bash.inc" ]; then source "$HOME/ycp/path.bash.inc"; fi
