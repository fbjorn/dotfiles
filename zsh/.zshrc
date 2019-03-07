source "$HOME/.zsh/antigen/antigen.zsh"

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent $(ls -1 ~/.ssh/id_* | grep -Ev '\.pub$' | xargs -n 1 basename | paste -sd ' ' -)

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  autojump
  colored-man-pages
  command-not-found
  gitfast
  ssh-agent
  mafredri/zsh-async
  sindresorhus/pure
  hcgraf/zsh-sudo
  hlissner/zsh-autopair
  Tarrasch/zsh-bd
  zsh-users/zsh-autosuggestions
  zsh-users/zsh-completions
  zdharma/fast-syntax-highlighting
EOBUNDLES
antigen apply

source "$HOME/.zsh/init.sh"
source "$HOME/.zsh/functions.sh"
source "$HOME/.zsh/aliases.sh"
source "$HOME/.zsh/binds.sh"
source "$HOME/.zsh/history.sh"

[[ -f "/usr/share/fzf/completion.zsh" ]] && source "/usr/share/fzf/completion.zsh"
[[ -f "/usr/share/fzf/key-bindings.zsh" ]] && source "/usr/share/fzf/key-bindings.zsh"

