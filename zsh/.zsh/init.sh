export ZSHRC="$HOME/.zshrc"
export VIMRC="$HOME/.vimrc"
export PYENV_ROOT="$HOME/.pyenv"

export HISTTIMEFORMAT="%d.%m.%y %H:%M:%S"

export PATH="/usr/local/bin:$PATH"
export PATH="$PYENV_ROOT/bin:$PATH"

export EDITOR=vim

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export GTAGSLABEL=pygments
if which rg > /dev/null; then
    export FZF_DEFAULT_COMMAND='rg --files'
else
    export FZF_DEFAULT_COMMAND='ag --nocolor --nogroup -l -g ""'
fi
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

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

