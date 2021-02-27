

source ~/.bash_aliases
source ~/.ssh_aliases

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/steve/Downloads/google-cloud-sdk/path.bash.inc' ]; then . '/Users/steve/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/steve/Downloads/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/steve/Downloads/google-cloud-sdk/completion.bash.inc'; fi

export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

eval "$(rbenv init -)"

