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

# get ruby version
RUBY_VERSION=`ruby --version | awk '{print $2}' | awk -F "." '{print $1"."$2".0"}'`

# update PATH variable
# add go, cargo, ruby, rvm, doom-emacs-bin, user-scripts-folder to path
# Make sure this is the last PATH variable change.
export PATH="$HOME/scripts:/usr/local/sbin:/usr/local/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.gem/ruby/$RUBY_VERSION/bin:$PATH:$HOME/.config/emacs/doom-emacs/.emacs.d/bin:$HOME/.rvm/bin"

# source virualenvwrapper for mkvirtualenv. virtualenvwrapper.sh must be in path.
source virtualenvwrapper.sh

# set DOOMDIR for DOOM to use our config
export DOOMDIR=$HOME/.config/emacs/doom-emacs/.doom.d

# source aliases
script_full_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
aliases_file=$(readlink -f $(dirname "$script_full_path")/aliases)
source $aliases_file

