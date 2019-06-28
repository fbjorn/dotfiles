#!/usr/bin/env zsh

bindkey "^R" history-incremental-pattern-search-backward
bindkey "^S" history-incremental-pattern-search-forward

zle -N edit-command-line
bindkey "^E" edit-command-line

backward-kill-path() {
    local WORDCHARS="*?_[]~=&;!#$%^(){}-/"
    zle backward-kill-word
}
zle -N backward-kill-path
bindkey "^W" backward-kill-path

