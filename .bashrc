# assume sycwin terminal on windows cmd prompt - for terminals to work correctly in windows.
if [[ "$OSTYPE" == "win32" ]]; then
    if [[ $TERM == vtpcon ]]; then
        export TERM=cygwin
    fi
fi

# source fzf bash completion and key bindings, use fd for fzf command on *nix system
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
if [[ "$OSTYPE" == "win32" ]]; then
    echo "looks good!"
else
    export FZF_DEFAULT_COMMAND='fd --type f'
fi

# get ruby version, not using system ruby path since rvm is used below.
# RUBY_VERSION=`ruby --version | awk '{print $2}' | awk -F "." '{print $1"."$2".0"}'`
# export PATH="$HOME/.gem/ruby/$RUBY_VERSION/bin:$PATH"

# update PATH variable
# add go, cargo, ruby, doom-emacs-bin, user-scripts-folder to path
export PATH="$HOME/scripts:/usr/local/sbin:/usr/local/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.config/emacs/doom-emacs/.emacs.d/bin:$PATH"

# source virualenvwrapper for mkvirtualenv. virtualenvwrapper.sh must be in path.
source virtualenvwrapper.sh
# use virtual python3.9
workon python3.9

# source nvm for npm and nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source rvm for ruby
source $HOME/.rvm/scripts/rvm

# set DOOMDIR for DOOM to use our config
export DOOMDIR=$HOME/.config/emacs/doom-emacs/.doom.d

# source aliases
script_full_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
aliases_file=$(readlink -f $(dirname "$script_full_path")/aliases)
source $aliases_file

