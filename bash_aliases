# ~/.bash_aliases

# silence cdspell echo
function cd () {
	builtin cd "$@" 1> /dev/null
}

function pidof () {
	ps -acxo 'pid,command' | grep -w "$1" | awk '{ print $1 }'
}

alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."
alias su="su -l" # '-l' discards current environment
alias sz="du -h -d1"
alias edit="vim"
alias pine="alpine"
alias ip="ipconfig getifaddr en0"
