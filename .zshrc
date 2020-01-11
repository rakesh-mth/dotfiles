[ -f "$HOME/.codex/codex.sh" ] && . "$HOME/.codex/codex.sh"

# update PATH variable
export PATH="/usr/local/bin:$HOME/.cargo/bin:$HOME/Library/Python/3.7/bin:$PATH"

# powerlevel10k theme for zsh
[ -f "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme" ] && source "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme"
POWERLEVEL9K_IGNORE_TERM_COLORS=true

[ -f "$HOME/software/.purepower" ] && source "$HOME/software/.purepower"

# source fzf completion and key binding, use fd as default fzf command
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# source python 2.7 environment 
[ -f "$HOME/virtualenvs/2.7/bin/activate" ] && source "$HOME/virtualenvs/2.7/bin/activate"

# key binding to move forward and backward using A-f and A-b
# bindkey "^[^[[C" forward-word
# bindkey "^[^[[D" backward-word
