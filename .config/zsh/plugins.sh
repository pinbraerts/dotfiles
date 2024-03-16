ZPLUG_HOME=$HOME/.local/share/zplug
if ! [ -d "$ZPLUG_HOME" ]; then
	git clone git@github.com:zplug/zplug.git "$ZPLUG_HOME"
fi
source "$ZPLUG_HOME/init.zsh"
zplug "jeffreytse/zsh-vi-mode", from:github
zplug "zsh-users/zsh-autosuggestions", from:github
zplug "zsh-users/zsh-syntax-highlighting", from:github
if ! zplug check; then
	zplug install
fi
zplug load
