#!/usr/bin/env zsh
bookmarks=~/.surf/bookmarks
reload="cat $bookmarks && ddg {q}"

query=$(cat $bookmarks | fzf \
	--bind "change:reload-sync:$reload" \
	--bind "tab:replace-query" \
	--bind "enter:replace-query+print-query" \
	--bind "ctrl-x:reload-sync:sed -i \"/\$(<<<'{+}' sed -e 's/[]\\/\$*.^[]/\\\\&/g')/d\" $bookmarks; $reload" \
)
[ -z "$query" ] && exit 1
regex='^((https?|ftp|file):\/\/)?[-A-Za-z0-9\+&@#\/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#\/%=~_|]\.[-A-Za-z0-9\+&@#\/%?=~_|!:,.;]*[-A-Za-z0-9\+&@#\/%=~_|]*$'
if ! [[ "$query" =~ $regex ]]; then
	query=$(urlencode "$query")
	query="https://duckduckgo.com/?q=$query"
fi
echo $query
