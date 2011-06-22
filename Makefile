#
# Makefile for dotfiles
# method inspired by https://github.com/pix/dotfiles 
#

DIR = 		bin
DOT_DIR = 	gnupg ssh vim
DOT_FILE = 	bash_profile bashrc bash_aliases inputrc \
		gitconfig gitignore gitattributes emrc vimrc \
		tarsnaprc gdbinit pinerc

all: install

install: $(HOME)/.history $(foreach f, $(DIR), install-dir-$(f)) \
	 $(foreach f, $(DOT_DIR), install-dotdir-$(f)) \
	 $(foreach f, $(DOT_FILE), install-file-$(f))

$(HOME)/.history:
	@echo " [mkdir] Creating ~/.history"
	@mkdir $(HOME)/.history 2>/dev/null

install-dir-%: %
	@echo " [ln]    Linking $< to ~/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<

install-dotdir-%: %
	@echo " [ln]    Linking $< to ~/.$<"
	@ln -snf $(CURDIR)/$< $(HOME)/.$<

install-file-%: %
	@echo " [ln]    Linking $< to ~/.$<"
	@ln -sf $(CURDIR)/$< $(HOME)/.$<

clean: $(foreach f, $(DIR), clean-$(f)) \
       $(foreach f, $(DOT_DIR), clean-.$(f)) \
       $(foreach f, $(DOT_FILE), clean-.$(f))

clean-%:
	@echo " [clean] Removing link ~/$*"
	@sh -c "if [ -h ~/$* ]; then rm ~/$*; fi"
