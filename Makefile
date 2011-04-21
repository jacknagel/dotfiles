#
# Makefile for dotfiles
#

# If regular files exist in places were symlinks are being created,
# a warning is produced and the symlink is skipped.

warning=is a regular file; skipped.
BASH_FILES=bash_profile bashrc bash_aliases inputrc
BIN_FILES=bin
GIT_FILES=gitconfig gitignore
GPG_FILES=gnupg
SSH_FILES=ssh
TARSNAP_FILES=tarsnaprc
UEMACS_FILES=emrc
VIM_FILES=vim vimrc

install: link-bash link-bin link-git link-gpg link-ssh link-tarsnap \
	 link-uemacs link-vim

link-bash:
	@for file in $(BASH_FILES); do \
	if test -L ~/.$${file} || ! test -f ~/.$${file}; \
	then rm -f ~/.$${file}; ln -sn `pwd`/$${file} ~/.$${file}; \
	else echo "~/.$${file} $(warning)"; fi \
	done;

link-bin:
	@for file in $(BIN_FILES); do \
	if test -L ~/$${file} || ! test -f ~/$${file}; \
	then rm -f ~/$${file}; ln -sn `pwd`/$${file} ~/$${file}; \
	else print ".$${file} $(warning)"; fi \
	done;

link-git:
	@for file in $(GIT_FILES); do \
	if test -L ~/.$${file} || ! test -f ~/.$${file}; \
	then rm -f ~/.$${file}; ln -sn `pwd`/$${file} ~/.$${file}; \
	else echo "~/.$${file} $(warning)"; fi \
	done;

link-gpg:
	@for file in $(GPG_FILES); do \
	if test -L ~/.$${file} || ! test -f ~/.$${file}; \
	then rm -f ~/.$${file}; ln -sn `pwd`/$${file} ~/.$${file}; \
	else print ".$${file} $(warning)"; fi \
	done;

link-ssh:
	@for file in $(SSH_FILES); do \
	if test -L ~/.$${file} || ! test -f ~/.$${file}; \
	then rm -f ~/.$${file}; ln -sn `pwd`/$${file} ~/.$${file}; \
	else print ".$${file} $(warning)"; fi \
	done;

link-tarsnap:
	@for file in $(TARSNAP_FILES); do \
	if test -L ~/.$${file} || ! test -f ~/.$${file}; \
	then rm -f ~/.$${file}; ln -sn `pwd`/$${file} ~/.$${file}; \
	else print ".$${file} $(warning)"; fi \
	done;

link-uemacs:
	@for file in $(UEMACS_FILES); do \
	if test -L ~/.$${file} || ! test -f ~/.$${file}; \
	then rm -f ~/.$${file}; ln -sn `pwd`/$${file} ~/.$${file}; \
	else print ".$${file} $(warning)"; fi \
	done;
	
link-vim:
	@for file in $(VIM_FILES); do \
	if test -L ~/.$${file} || ! test -f ~/.$${file}; \
	then rm -f ~/.$${file}; ln -sn `pwd`/$${file} ~/.$${file}; \
	else print ".$${file} $(warning)"; fi \
	done;
