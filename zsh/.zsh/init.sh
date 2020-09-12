export ZSHRC="$HOME/.zshrc"
export VIMRC="$HOME/.vimrc"

export LC_ALL=en_US.UTF-8
export HISTTIMEFORMAT="%d.%m.%y %H:%M:%S"
export EDITOR=vim

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export GTAGSLABEL=pygments

# --- fzf ---
[[ -f "/usr/local/opt/fzf/shell/completion.zsh" ]] && source "/usr/local/opt/fzf/shell/completion.zsh"
[[ -f "/usr/local/opt/fzf/shell/key-bindings.zsh" ]] && source "/usr/local/opt/fzf/shell/key-bindings.zsh"
if which rg > /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
else
    export FZF_DEFAULT_COMMAND='ag --nocolor --nogroup -l -g ""'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# --- Terminal ---
export PURE_PROMPT_SYMBOL="➜"
# to avoid https://github.com/neovim/neovim/issues/6982
export COLORTERM=truecolor

# Set proper TERM for tmux
if [ -n "$TMUX" ]; then
    export TERM=tmux-256color
else
    export TERM=xterm-256color
fi

if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
    source /etc/profile.d/vte.sh
fi

export BAT_THEME="OneHalfDark"

# --- Go ---
export GOPATH="$HOME/go"
export PATH="$PATH:$GOPATH/bin"

# --- Travis ---
[ ! -s /Users/denis/.travis/travis.sh ] || source /Users/denis/.travis/travis.sh

# --- Google Cloud ---
export CLOUDSDK_PYTHON=/usr/bin/python3
if [ -f '/Users/denis/sandbox/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/denis/sandbox/google-cloud-sdk/path.zsh.inc'; fi
if [ -f '/Users/denis/sandbox/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/denis/sandbox/google-cloud-sdk/completion.zsh.inc'; fi

# --- Patching PATH ---
export PATH="/usr/local/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"
export PATH="/usr/local/opt/qt/bin:$PATH"
#export PATH="$PATH:/usr/local/opt/node@12/bin"

# --- C++ stuff ---
export LDFLAGS="-L/usr/local/opt/openssl/lib -L/usr/local/lib -L/usr/local/opt/expat/lib"
export CFLAGS="-I/usr/local/opt/openssl/include/ -I/usr/local/include -I/usr/local/opt/expat/include"
export CPPFLAGS="-I/usr/local/opt/openssl/include/ -I/usr/local/include -I/usr/local/opt/expat/include"

# --- Python ---
export PYENV_ROOT="$HOME/.pyenv"
eval "$(pyenv init -)"

[[ -f "$HOME/.poetry/env" ]] && source "$HOME/.poetry/env"

