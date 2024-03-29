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

# zoxide (a better cd)
command -v zoxide &> /dev/null && eval "$(zoxide init bash)"

# get ruby version, not using system ruby path since rvm is used below.
# RUBY_VERSION=`ruby --version | awk '{print $2}' | awk -F "." '{print $1"."$2".0"}'`
# export PATH="$HOME/.gem/ruby/$RUBY_VERSION/bin:$PATH"

# update PATH variable
# add go, cargo, ruby, doom-emacs-bin, user-scripts-folder to path
export PATH="$HOME/scripts:$HOME/windows:$$HOME/workspaces/rakesh-mth/dotfiles/LINUX/scripts:/usr/local/sbin:/usr/local/bin:$HOME/go/bin:$HOME/.cargo/bin:$HOME/.config/emacs/doom-emacs/.emacs.d/bin:$PATH"

# source virualenvwrapper for mkvirtualenv. virtualenvwrapper.sh must be in path.
command -v virtualenvwrapper.sh &> /dev/null && source virtualenvwrapper.sh
# use virtual python3.9
[ -d $HOME/.virtualenvs/python3.9/ ] && workon python3.9

# source nvm for npm and nodejs
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && source "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# source rvm for ruby
[ -s $HOME/.rvm/scripts/rvm ] && source $HOME/.rvm/scripts/rvm

# set DOOMDIR for DOOM to use our config
export DOOMDIR=$HOME/.config/emacs/doom-emacs/.doom.d

# set runtime path for LunarVim - this is to make sure multiple config can work together.
export LUNARVIM_RUNTIME_DIR=$HOME/.local/share/nvim/LunarVim

# brew do not use bottle from source
export HOMEBREW_NO_BOTTLE_SOURCE_FALLBACK=1

# source McFly (only if fzf not found)
if type "mcfly" > /dev/null; then
    [ ! -f ~/.fzf.bash ] && eval "$(mcfly init bash)"
fi

# source aliases
script_full_path="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
aliases_file=$(readlink -f $(dirname "$script_full_path")/aliases)
source $aliases_file

