if [[ -n ${ZSH_VERSION:-} ]]; then
	shell=zsh
elif [[ -n ${BASH_VERSION:-} ]]; then
	shell=bash
else
	return
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv >/dev/null 2>&1; then
	eval "$(pyenv init - "$shell")"
fi
if command -v starship >/dev/null 2>&1; then
	eval "$(starship init "$shell")"
fi
if command -v zoxide >/dev/null 2>&1; then
	eval "$(zoxide init --cmd cd "$shell")"
fi
if command -v fzf >/dev/null 2>&1; then
	eval "$(fzf --"$shell")"
fi
# eval "$(\"$MAMBA_EXE\" shell hook --shell $shell --root-prefix \"$MAMBA_ROOT_PREFIX\" 2> /dev/null)" 2>/dev/null

export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# The next line updates PATH for Yandex Cloud CLI.
if [ -f "$HOME/yandex-cloud/path.bash.inc" ]; then source "$HOME/yandex-cloud/path.bash.inc"; fi

# The next line enables shell command completion for Yandex Cloud CLI.
# if [ -f "$HOME/yandex-cloud/completion.zsh.inc" ]; then source "$HOME/yandex-cloud/completion.zsh.inc"; fi

# The next line updates PATH for Yandex Cloud Private CLI.
if [ -f "$HOME/ycp/path.bash.inc" ]; then source "$HOME/ycp/path.bash.inc"; fi
