[ -f "$HOME/.codex/codex.sh" ] && . "$HOME/.codex/codex.sh"
[ -f "$HOME/software/.purepower" ] && source "$HOME/software/.purepower"

# powerlevel10k theme for zsh - only oh-my-zsh is not used
if [[ -z $ZSH_THEME ]]; then
    [ -f "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme" ] && source "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme"
    POWERLEVEL9K_IGNORE_TERM_COLORS=true
fi

# get ruby version, not using system ruby path since rvm is used below.
# RUBY_VERSION=`ruby --version | awk '{print $2}' | awk -F "." '{print $1"."$2".0"}'`
# export PATH="$HOME/.gem/ruby/$RUBY_VERSION/bin:$PATH"

# update PATH variable
export PATH="/usr/local/sbin:/usr/local/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.config/emacs/doom-emacs/.emacs.d/bin:$PATH"

# DOOMDIR for doom-emacs
export DOOMDIR=$HOME/.config/emacs/doom-emacs/.doom.d

# source fzf completion and key binding, use fd as default fzf command
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# brew do not use bottle from source
export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1

# Configuration for virtualenv. # WORKON_HOME for virualenvs selection in emacs
# WORKON_HOME is set by vierualenvwrapper.sh if it is not set.
# export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=`which python3`
export VIRTUALENVWRAPPER_VIRTUALENV=`which virtualenv`
[ -f "/usr/local/bin/virtualenvwrapper.sh" ] && source "/usr/local/bin/virtualenvwrapper.sh"

# source nvm for npm and nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source rvm for ruby
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# enable autocomplete (git and others)
autoload -Uz compinit && compinit

# key binding to move forward and backward using A-f and A-b
# bindkey "^[^[[C" forward-word
# bindkey "^[^[[D" backward-word

# set default EDITOR
export EDITOR=nvim

# set LANG - for python3 to work over ssh
export LANG="en_US.UTF-8"

# exit terminal app
alias quit='osascript -e "do shell script \"osascript -e \\\"tell application \\\\\\\"Terminal\\\\\\\" to quit\\\" &> /dev/null &\""; exit'
alias q=quit

################################################################################
##################################### aliases ##################################
# open ~/.zshrc in using the default editor specified in $EDITOR
alias ez="$EDITOR $HOME/.zshrc"
# source ~/.zshrc
alias sz="source $HOME/.zshrc"
# source aliases
script_full_path=$(realpath ${(%):-%N})
source $(dirname $script_full_path)/aliases
# source ${0:a:h}/aliases # does not work with link
################################################################################
################################################################################

