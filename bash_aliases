# ~/.bash_aliases

# silence cdspell echo
cd () {
	builtin cd "$@" 1> /dev/null
}

pidof () {
	ps -acxo 'pid,command' | grep -w "$1" | awk '{ print $1 }'
}

alias cd..="cd .."
alias du1="du -h -d1"
alias edit="vim"
alias fn="find . -name"
alias ip="ipconfig getifaddr en0"
alias pine="alpine"
alias sqlite="sqlite3"
alias vg="valgrind"
