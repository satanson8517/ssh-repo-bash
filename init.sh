# Path to variables of SSH agent (PID, etc.)
SSH_ENV="$HOME/.ssh/ssh-agent-env"

# Starts new SSH agent
function start_agent {
    (umask 066; /usr/bin/ssh-agent > "${SSH_ENV}")
    . "${SSH_ENV}" > /dev/null
    /usr/bin/ssh-add /c/Users/<username>/.ssh/<key> > /dev/null 2>&1;
}

# Source SSH settings, if applicable
if [ -f "${SSH_ENV}" ]; then
    . "${SSH_ENV}" > /dev/null
    ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$  > /dev/null || {
        start_agent;
    }
else
    start_agent;
fi
	
# add npm to PATH
PATH="$PATH:/cygdrive/c/Users/<user>/AppData/Roaming/npm"
