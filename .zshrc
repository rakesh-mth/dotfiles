[ -f "$HOME/.codex/codex.sh" ] && . "$HOME/.codex/codex.sh"
[ -f "$HOME/software/.purepower" ] && source "$HOME/software/.purepower"

# powerlevel10k theme for zsh - only oh-my-zsh is not used
if [[ -z $ZSH_THEME ]]; then
    [ -f "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme" ] && source "$HOME/software/powerlevel10k/powerlevel10k.zsh-theme" && POWERLEVEL9K_IGNORE_TERM_COLORS=true
fi

# source fzf completion and key binding, use fd as default fzf command
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh && export FZF_DEFAULT_COMMAND='fd --type f'

# zoxide (a better cd)
command -v zoxide &> /dev/null && eval "$(zoxide init zsh)"

# broot - (a better tree)
[ -f $HOME/.config/broot/launcher/bash/br ] && source $HOME/.config/broot/launcher/bash/br

# get ruby version, not using system ruby path since rvm is used below.
# RUBY_VERSION=`ruby --version | awk '{print $2}' | awk -F "." '{print $1"."$2".0"}'`
# export PATH="$HOME/.gem/ruby/$RUBY_VERSION/bin:$PATH"

# update PATH variable. make sure $HOME/github/dotfiles exists
export PATH="$HOME/scripts:$HOME/windows:$HOME/github/dotfiles/LINUX/scripts:/usr/local/sbin:/usr/local/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.config/emacs/doom-emacs/.emacs.d/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
    PATH=$(pyenv root)/shims:$PATH
fi

# Configuration for virtualenv. # WORKON_HOME for virualenvs selection in emacs
# WORKON_HOME is set by vierualenvwrapper.sh if it is not set.
# export WORKON_HOME=$HOME/.virtualenvs
export VIRTUALENVWRAPPER_PYTHON=`which python3`
export VIRTUALENVWRAPPER_VIRTUALENV=`which virtualenv`
# source virualenvwrapper for mkvirtualenv. virtualenvwrapper.sh must be in path.
command -v virtualenvwrapper.sh &> /dev/null && source virtualenvwrapper.sh
# use virtual python3.9
[ -d $HOME/.virtualenvs/python3.9/ ] && workon python3.9

# source nvm for npm and nodejs
[ -s "$NVM_DIR/nvm.sh" ] && export NVM_DIR="$HOME/.nvm" && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source rvm for ruby
[ -f "$HOME/.rvm/scripts/rvm" ] && source "$HOME/.rvm/scripts/rvm"

# set DOOMDIR for DOOM to use our config
[ -f $HOME/.config/emacs/doom-emacs/.doom.d ] && export DOOMDIR=$HOME/.config/emacs/doom-emacs/.doom.d

# set runtime path for LunarVim - this is to make sure multiple config can work together.
[ -f $HOME/.local/share/nvim/LunarVim ] && export LUNARVIM_RUNTIME_DIR=$HOME/.local/share/nvim/LunarVim

# brew do not use bottle from source
export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1

# source McFly (only if fzf not found)
if type "mcfly" > /dev/null; then
   [ ! -f ~/.fzf.zsh ] && eval "$(mcfly init zsh)"
fi

# enable autocomplete (git and others)
autoload -Uz compinit && compinit

# key binding to move forward and backward using A-f and A-b
# bindkey "^[^[[C" forward-word
# bindkey "^[^[[D" backward-word

# set default EDITOR to nvim if nvim is installed and in the path
command -v nvim &> /dev/null && export EDITOR=nvim

# set LANG - for python3 to work over ssh
export LANG="en_US.UTF-8"

# os specific config
if [[ $OSTYPE == darwin* ]]; then
    # add xcode tools into path on mac osx
    export PATH=/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin:/Applications/Xcode.app/Contents/Developer/usr/bin:$PATH
    # needed for c/c++ header files (ex: stdlib.h)
    export SDKROOT=$(xcrun --sdk macosx --show-sdk-path) 
    # exit terminal app
    alias quit='osascript -e "do shell script \"osascript -e \\\"tell application \\\\\\\"Terminal\\\\\\\" to quit\\\" &> /dev/null &\""; exit'
    alias q=quit
fi


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

################################################################################
##################################### functions ################################
# gitignore
function gi() { curl -L -s https://www.gitignore.io/api/$@ ;}

function docker_deep_clean() {
    echo "Removing exited containers..."
    echo "============================="
    docker ps --filter status=dead --filter status=exited -aq | xargs docker rm -v
    echo ""
    echo "Removing unused images..."
    echo "========================="
    docker images --no-trunc | grep '<none>' | awk '{ print $3 }' | xargs docker rmi
    echo ""
    echo "Removing unused volumes..."
    echo "=========================="
    docker volume ls -qf dangling=true | xargs docker volume rm
    echo ""
    echo "Done."
}
