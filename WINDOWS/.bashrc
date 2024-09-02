if [[ $TERM == vtpcon ]]; then
    export TERM=cygwin
fi

# Set up ssh-agent
SSH_ENV="$HOME/.ssh/environment"

function start_agent {
    echo "Initializing new SSH agent..."
    touch $SSH_ENV
    chmod 600 "${SSH_ENV}"
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' >> "${SSH_ENV}"
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add
    /usr/bin/ssh-add ~/.ssh/id_rsa
    /usr/bin/ssh-add ~/.ssh/id_rsa_github
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    kill -0 $SSH_AGENT_PID 2>/dev/null || {
        start_agent
    }
else
    start_agent
fi

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

command -v zoxide &> /dev/null && eval "$(zoxide init bash)"

