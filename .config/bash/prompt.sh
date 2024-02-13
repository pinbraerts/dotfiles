if [[ $TERM == linux ]]; then
	l=''
	r=''
	v='v'
	x='x'
else
	l=$(echo -ne "\ue0b6")
	r=$(echo -ne "\ue0b4")
	v=$(echo -ne "\u2713")
	x=$(echo -ne "\u2717")
fi

which tput >/dev/null 2>&1 && [ -n "$(tput colors)" ]
support=$?

function c() {
	[[ $support -ne 0 ]] && : && return
	result="\033[${1}m"
	[[ $# -gt 1 ]] && result="\[$result\]"
	printf "$result"
}

function prompt() {
	printf "$(c '34' 1)$l$(c '44;01;37' 1)\\w"
	branch=$(git branch --show-current 2>/dev/null)
	if [ -n "$branch" ]; then
		printf " $(c '47;01;34' 1) $branch$(c '0;37' 1)"
	else
		branch=$(git rev-parse --short HEAD 2>/dev/null)
		if [ -n "$branch" ]; then
			printf " $(c '47;01;34' 1) $branch$(c '0;37' 1)"
		else
			printf "$(c '0;34' 1)"
		fi
	fi
	printf "$r$(c '0' 1) "
}

function format() {
	result=
	value=${1:-0}
	suffixes=(ms s m h d)
	scales=(1000 60 60 24 0)
	for i in $(seq 0 $((${#suffixes[@]} - 1))); do
		[[ $value -eq 0 ]] && break
		suffix=${suffixes[$i]}
		divisor=${scales[$i]}
		if [[ $divisor -eq 0 ]]; then
			digit=$value
			value=0
		else
			digit=$(($value % $divisor))
			value=$(($value / $divisor))
		fi
		result="$digit$suffix $result"
	done
	echo -n "$result"
}

function msec() {
	date +%s%3N
}

function status() {
	code=$?
	delta=$(($(msec) - $timer))
	[ $delta -lt 10 ] && delta=0
	case "$code,$delta" in
		0,0)
			:
			return
			;;
		0,*)
			code=" $v"
			color=2
			back=4
			;;
		*,0)
			code="$code $x"
			color=1
			back=7
			;;
		*)
			code=" $code $x"
			color=1
			back=7
			;;
	esac
	delta=$(format $delta)
	width=${COLUMNS:-$(tput cols)}
	length=$((${#delta} + ${#code} + ${#l} + ${#r} - 1))
	result="\033[${width}C\033[${length}D"
	if [[ -z $delta ]]; then
		result+="$(c "3$color")$l"
	else
		result+="$(c '34')$l$(c '44;37')$delta"
	fi
	result+="$(c "4$color;3${back}")$code$(c "0;3${color}")$r"
	echo -ne "\[\033[s$result$(c 0)\033[u\]"
}

function update_prompt() {
	PS1="$(status)$(prompt)"
	unset timer
}

trap 'timer=${timer:-$(msec)}' DEBUG
export PROMPT_COMMAND=update_prompt
