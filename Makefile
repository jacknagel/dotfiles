#
# Makefile
#

install: link-bash link-git link-vim link-ssh link-bin

link-bash:
	rm -f ~/.bash_profile ~/.bashrc ~/.bash_prompt ~/.bash_aliases ~/.inputrc
	ln -sn `pwd`/bash_profile ~/.bash_profile
	ln -sn `pwd`/bashrc ~/.bashrc
	ln -sn `pwd`/bash_prompt ~/.bash_prompt
	ln -sn `pwd`/bash_aliases ~/.bash_aliases
	ln -sn `pwd`/inputrc ~/.inputrc

link-git:
	rm -f ~/.gitconfig ~/.gitignore
	ln -sn `pwd`/gitconfig ~/.gitconfig
	ln -sn `pwd`/gitignore ~/.gitignore

link-vim:
	rm -f ~/.vim ~/.vimrc
	ln -sn `pwd`/vim ~/.vim
	ln -sn `pwd`/vimrc ~/.vimrc

link-ssh:
	rm -f ~/.ssh
	ln -sn `pwd`/ssh ~/.ssh

link-bin:
	rm -f ~/bin
	ln -sn `pwd`/bin ~/bin
