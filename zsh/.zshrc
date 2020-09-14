source "$HOME/.zsh/antigen/antigen.zsh"

zstyle :omz:plugins:ssh-agent agent-forwarding on
zstyle :omz:plugins:ssh-agent $(ls -1 ~/.ssh/id_* | grep -Ev '\.pub$' | xargs -n 1 basename | paste -sd ' ' -)

antigen use oh-my-zsh
antigen bundles <<EOBUNDLES
  autojump
  colored-man-pages
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
[[ -f "$HOME/.zsh/custom.sh" ]] && source "$HOME/.zsh/custom.sh"

# must be there for some reason. fuzzy ctrl+r won't work if move it to init.sh
[[ -f "/usr/local/opt/fzf/shell/completion.zsh" ]] && source "/usr/local/opt/fzf/shell/completion.zsh"
[[ -f "/usr/local/opt/fzf/shell/key-bindings.zsh" ]] && source "/usr/local/opt/fzf/shell/key-bindings.zsh"