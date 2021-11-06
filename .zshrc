[ -f "$HOME/.codex/codex.sh" ] && . "$HOME/.codex/codex.sh"

RUBY_VERSION=`ruby --version | awk '{print $2}' | awk -F "." '{print $1"."$2".0"}'`

# update PATH variable
export PATH="/usr/local/sbin:/usr/local/bin:$HOME/.cargo/bin:$HOME/.gem/ruby/$RUBY_VERSION/bin:$PATH:$HOME/.config/emacs/doom-emacs/.emacs.d/bin"

# DOOMDIR for doom-emacs
export DOOMDIR=$HOME/.config/emacs/doom-emacs/.doom.d

# powerlevel10k theme for zsh - only oh-my-zsh is not used
if [[ -z $ZSH_THEME ]]; then
    [ -f "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme" ] && source "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme"
    POWERLEVEL9K_IGNORE_TERM_COLORS=true
fi

[ -f "$HOME/software/.purepower" ] && source "$HOME/software/.purepower"

# source fzf completion and key binding, use fd as default fzf command
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_COMMAND='fd --type f'

# brew do not use bottle from source
export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1

# Configuration for virtualenv. # WORKON_HOME for virualenvs selection in emacs
export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python3
export VIRTUALENVWRAPPER_VIRTUALENV=/usr/local/bin/virtualenv
source /usr/local/bin/virtualenvwrapper.sh

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

################################################################################
##################################### aliases ##################################
alias se="emacs --with-profile spacemacs"
alias de="emacs --with-profile doom"
alias e="emacs --with-profile default"
alias sec="emacs -nw --with-profile spacemacs"
alias dec="emacs -nw --with-profile doom"
alias ec="emacs -nw --with-profile default"
alias dus="du -sh * | sort -n -r"
alias dfh="df -h"
# open ~/.zshrc in using the default editor specified in $EDITOR
alias ez="$EDITOR $HOME/.zshrc"
# source ~/.zshrc
alias sz="source $HOME/.zshrc"
if [[ $OSTYPE == darwin* ]]; then
    alias route4="netstat -f inet -rl"
    alias pfnat="sudo pfctl -sa 2>/dev/null | grep nat"
fi
# applications
if [[ $OSTYPE == darwin* ]]; then
    alias chrome="open -a /Applications/Google\ Chrome.app"
    alias safari="open -a Safari"
fi
alias et="emacs -nw"
alias vcode="open -a /Applications/VSCodium.app"
alias xcode="open -a /Applications/Xcode.app"
alias settings="open -a System\ Preferences"
alias apps="open -a App\ Store"
alias finder="open -a Finder"
alias ss="open -a Screen\ Sharing"
alias da="open -a Docker"
alias ut="open -a uTorrent"
alias vbox="open -a /Applications/VirtualBox.app"
# open links
alias gs="safari http://google.com"
alias gc="chrome http://google.com"
# network
alias dns="scutil --dns | grep 'nameserver\[[0-9]*\]'"
################################################################################

# add doom emacs bin to path
export PATH=~/.config/emacs/doom-emacs/.emacs.d/bin/:$PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
