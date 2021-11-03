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

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
