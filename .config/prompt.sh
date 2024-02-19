milliseconds() {
	date +%s%3N
}

format_time() {
	ms=$(($1 % 1000))
	s=$(($1 / 1000))
	m=$(($s / 60))
	s=$(($s % 60))
	h=$(($m / 60))
	m=$(($m % 60))
	d=$(($h / 24))
	h=$(($h % 24))
	[ $d -gt 0 ] && echo -ne "${d}d "
	[ $h -gt 0 ] && echo -ne "${h}h "
	[ $m -gt 0 ] && echo -ne "${m}m "
	[ $s -gt 0 ] && echo -ne "${s}s "
	echo -ne "${ms}ms"
}

preexec() {
	timer=$(milliseconds)
}
preexec

precmd() {
	vcs_info
	if [ $timer ]; then
		elapsed=$(format_time $(($(milliseconds) - $timer)))
		unset timer
	fi
}

case $(ls -l /proc/$$/exe) in
	*bash)
		vcs_info() {
			vcs_info_msg_0_=$(git branch --show-current 2>/dev/null || true)
			if [[ -z $vcs_info_msg_0_ ]]; then
				vcs_info_msg_0_=$(git rev-parse --short HEAD 2>/dev/null || true)
			fi
			if [[ -z $vcs_info_msg_0_ ]]; then
				vcs_info_msg_0_=
				return
			fi
			if [[ -n $(git diff --shortstat) ]]; then
				vcs_info_msg_0_="$vcs_info_msg_0_ \[$(tput setf 6)\]*"
			fi
			vcs_info_msg_0_="\[$(tput setf 5)\]  $vcs_info_msg_0_"
			export vcs_info_msg_0_
		}

		update_prompt() {
			status=$?
			precmd
			if [ $status -eq 0 ]; then
				mod=$(tput setf 2)
				tick="✓"
			else
				mod=$(tput setf 4)
				tick="$status ✗"
			fi
			RPROMPT="$elapsed $tick"
			width=${COLUMNS:-$(tput cols)}
			length=${#RPROMPT}
			RPROMPT="\033[s\033[${width}C\033[${length}D$elapsed $mod$tick\033[u"
			PS1="\[$RPROMPT$(tput setf 3)\]\\w$vcs_info_msg_0_ "
			if [ $EUID -eq 0 ]; then
				PS1="$PS1\[$mod\]#"
			else
				PS1="$PS1\[$mod\]%"
			fi
			PS1="$PS1\[$(tput sgr0)\] "
		}

		trap preexec DEBUG
		PROMPT_COMMAND=update_prompt
		;;

	*zsh)
		setopt prompt_subst
		autoload -Uz vcs_info
		zstyle ':vcs_info:*' get-revision true
		zstyle ':vcs_info:*' check-for-changes true
		zstyle ':vcs_info:*' unstagedstr ' %F{yellow}*%f'
		# zstyle ':vcs_info:*' stagedstr ' %F{yellow}+%f'
		zstyle ':vcs_info:*' enable git
		zstyle ':vcs_info:git:*' formats ' %f%F{magenta} %b%u'
		zstyle ':vcs_info:git:*' actionformats ' %f%F{magenta} %b|%a%u'
		PS1='%F{cyan}%~$vcs_info_msg_0_ %(?.%F{green}.%F{red})%#%f '
		RPROMPT='$elapsed %(?.%F{green}✓.%F{red}%? ✗)%f'
		;;
esac
