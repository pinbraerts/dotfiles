#!/usr/bin/env sh
bookmarks=~/.surf/bookmarks
reload="cat $bookmarks && ddg {q}"

query=$(cat $bookmarks | fzf \
	--bind "change:reload-sync:$reload" \
	--bind "tab:replace-query" \
	--bind "enter:replace-query+print-query" \
	--bind "ctrl-x:reload-sync:bm {+}; $reload" \
)
[ -z "$query" ] && exit 1
if echo "$query" | grep -q -v -e "\."; then
	query=$(urlencode "$query")
	query="https://duckduckgo.com/?q=$query"
fi
echo $query
