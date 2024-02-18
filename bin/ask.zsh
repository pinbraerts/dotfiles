prompt="${1:->} "
shift
if [ $# -eq 0 ]; then
	param='-i'
else
	param='-w $1'
fi
st $param -g 100x1 -e zsh -c "read \"REPLY?$prompt\" && echo \$REPLY > /proc/$$/fd/1"
