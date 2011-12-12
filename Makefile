DIR = 		bin
DOT_FILE = 	bash_profile bashrc bash_aliases inputrc \
		gitconfig gitignore gitattributes emrc vimrc \
		tarsnaprc gdbinit pinerc procmailrc valgrindrc \
		sqliterc

all: install

install: $(HOME)/.history $(foreach f, $(DIR), install-dir-$(f)) \
	 $(foreach f, $(DOT_DIR), install-dotdir-$(f)) \
	 $(foreach f, $(DOT_FILE), install-file-$(f))

$(HOME)/.history:
	@echo "  MKDIR Creating ~/.history"
	@mkdir $(HOME)/.history 2>/dev/null

install-dir-%: %
	@echo "  LN  $< to ~/$<"
	@ln -snf $(CURDIR)/$< $(HOME)/$<

install-file-%: %
	@echo "  LN  $< to ~/.$<"
	@ln -sf $(CURDIR)/$< $(HOME)/.$<

clean: $(foreach f, $(DIR), clean-$(f)) \
       $(foreach f, $(DOT_DIR), clean-.$(f)) \
       $(foreach f, $(DOT_FILE), clean-.$(f))

clean-%:
	@echo "  CLEAN  ~/$*"
	@sh -c "if [ -h ~/$* ]; then rm ~/$*; fi"

.PHONY : clean
