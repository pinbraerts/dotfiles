x=${1:-70}
w=${2:-100}
h=${3:-16}
a=$(($x * $h / $w / 9))
b=$(($x * $h / $w % 9))
c=$(($h / 9 - $a))

c() {
	case $1 in
		0) printf " " ;;
		1) printf "\u258f" ;;
		2) printf "\u258e" ;;
		3) printf "\u258d" ;;
		4) printf "\u258c" ;;
		5) printf "\u258b" ;;
		6) printf "\u258a" ;;
		7) printf "\u2589" ;;
		8) printf "\u2588" ;;
	esac
}

for i in $(seq 1 $a); do
	printf "\e[48;5;%im " $i
done
printf "\033[0m\033[38;5;%im%c" $a $a
c $b
printf "%${c}s"

echo
