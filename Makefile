all: tmp update link

tmp:
	@mkdir -p _backup _tmp _undo

update:
	@echo "  GIT submodule update --init"
	@git submodule update --init

link:
	@echo "  LN ~/etc/vimfiles ~/.vim"
	@if test ! -L $$HOME/.vim; \
	 then echo "  ERROR: ~/.vim is a real directory"; \
	 else ln -snf $$HOME/etc/vimfiles $$HOME/.vim; \
	 fi

	@echo "  LN ~/etc/vimfiles/vimrc ~/.vimrc"
	@if test ! -L $$HOME/.vimrc; \
	 then echo "  ERROR ~/.vimrc is a real file"; \
	 else ln -snf $$HOME/etc/vimfiles/vimrc $$HOME/.vimrc; \
	 fi

.PHONY: tmp update link
