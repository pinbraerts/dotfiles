ANTIDOTE_PATH=$HOME/.local/share/antidote
if ! [ -d "$ANTIDOTE_PATH" ]; then
	git clone --depth=1 https://github.com/mattmc3/antidote.git "$ANTIDOTE_PATH"
fi
zstyle ':antidote:bundle' use-friendly-names 'yes'
source "$ANTIDOTE_PATH/antidote.zsh"
antidote load
