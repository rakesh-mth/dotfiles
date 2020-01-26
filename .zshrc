[ -f "$HOME/.codex/codex.sh" ] && . "$HOME/.codex/codex.sh"

RUBY_VERSION=`ruby --version | awk '{print $2}' | awk -F "." '{print $1"."$2".0"}'`

# update PATH variable
export PATH="/usr/local/bin:$HOME/.cargo/bin:$HOME/Library/Python/3.7/bin:$HOME/.gem/ruby/$RUBY_VERSION/bin:$PATH"

# powerlevel10k theme for zsh
[ -f "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme" ] && source "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme"
POWERLEVEL9K_IGNORE_TERM_COLORS=true

[ -f "$HOME/software/.purepower" ] && source "$HOME/software/.purepower"

# source fzf completion and key binding, use fd as default fzf command
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# source python 2.7 environment 
[ -f "$HOME/virtualenvs/python27/bin/activate" ] && source "$HOME/virtualenvs/python27/bin/activate"

# WORKON_HOME for virualenvs selection in emacs
export WORKON_HOME=~/virtualenvs/

# enable autocomplete (git and others)
autoload -Uz compinit && compinit

# key binding to move forward and backward using A-f and A-b
# bindkey "^[^[[C" forward-word
# bindkey "^[^[[D" backward-word
