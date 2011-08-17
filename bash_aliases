# ~/.bash_aliases

# silence cdspell echo
function cd () {
	builtin cd "$@" 1> /dev/null
}

function pidof () {
	ps -acxo 'pid,command' | grep -w "$1" | awk '{ print $1 }'
}

alias ..='cd ..'
alias ...='cd ../../'
alias cd..='cd ..'
alias fl='ls -lFrtah | less -R'
alias edit='vim'
alias uemacs='em'
alias vi='vim'
alias sizes='du -h -d1'
alias weather='python3 ~/bin/pyweather 58102'
alias ip='ipconfig getifaddr en0'
alias ifip='ifconfig | grep inet'
alias killws="perl -pe \'s/[\t ]+$//g\'"
alias su='su -l' # -l: discard current environment
alias pine='alpine'
alias gpg='gpg2'
