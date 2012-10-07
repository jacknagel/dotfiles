# ~/.bash_aliases

# silence cdspell echo
cd () {
	builtin cd "$@" >/dev/null
}

pidof () {
	ps -acxo 'pid,command' | grep -w "$1" | awk '{ print $1 }'
}

setup_gpg_session () {
	local file="$HOME/.gnupg/agent.env"
	if [[ -f "$file" ]] && kill -0 "$(grep -e "GPG_AGENT_INFO" "$file" | cut -d: -f 2)" 2>/dev/null
	then
		eval "$(cat "$file")"
	else
		eval "$(gpg-agent --daemon --write-env-file="$file")"
	fi

	GPG_TTY=$(tty)
	export GPG_TTY GPG_AGENT_INFO
}

alias cd..="cd .."
alias du1="du -h -d1"
alias edit="vim"
alias fn="find . -name"
alias ip="ipconfig getifaddr en0"
alias pine="alpine"
alias sqlite="sqlite3"
alias vg="valgrind"
alias vi="vim"
alias mate="vim"
