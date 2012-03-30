# ~/.bash_aliases

# silence cdspell echo
cd () {
	builtin cd "$@" 1> /dev/null
}

pidof () {
	ps -acxo 'pid,command' | grep -w "$1" | awk '{ print $1 }'
}

__brew_ps1 ()
{
	[[ -z $HOMEBREW_DEBUG_INSTALL ]] ||
		printf "${1:- (%s)}" "$HOMEBREW_DEBUG_INSTALL|DEBUG"
}

alias ..="cd .."
alias ...="cd ../.."
alias cd..="cd .."
alias su="su -l" # '-l' discards current environment
alias sz="du -h -d1"
alias edit="vim"
alias pine="alpine"
alias ip="ipconfig getifaddr en0"
alias sqlite="sqlite3"
alias vg="valgrind"
