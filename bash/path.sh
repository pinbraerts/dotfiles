export PATH="$HOME/bin:$HOME/go/bin:$HOME/.local/bin:$PATH"

if ! [[ "$MANPATH" =~ "$HOME/share/man:" ]]; then
	MANPATH="$HOME/share/man:$MANPATH"
fi
export MANPATH

if ! [[ "$LD_LIBRARY_PATH" =~ "$HOME/lib:/usr/local/lib:" ]]; then
	LD_LIBRARY_PATH=$HOME/lib:/usr/local/lib:$LD_LIBRARY_PATH
fi
export LD_LIBRARY_PATH
