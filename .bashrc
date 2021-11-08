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

# source virualenvwrapper for mkvirtualenv. virtualenvwrapper.sh must be in path.
source virtualenvwrapper.sh

# set DOOMDIR for DOOM to use our config
export DOOMDIR=$HOME/.config/emacs/doom-emacs/.doom.d

# add doom emacs bin to path
export PATH=~/.config/emacs/doom-emacs/.emacs.d/bin/:$PATH

# add user script folder to path
export PATH=~/scripts:$PATH

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# source aliases
script_full_path=$(dirname "$0")
aliases_file=$(readlink -f $script_full_path/aliases)
source $aliases_file

