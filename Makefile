all: stow

stow:
	stow -t $(HOME) -R -v zsh sqlite3 vim

