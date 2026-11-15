# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export PATH=$HOME/bin:/usr/local/bin:$PATH

alias reload="source ~/.zshrc"

# git
alias gcm="git commit -m"
alias gs="git status"
alias gp="git push"
alias ga="git add ."
alias gd="git diff"
alias gc="git checkout -- "
alias gb="git branch"

# docker
alias d=docker
alias dc=docker-compose
alias db="docker build"
alias dr="docker run"
alias de="docker exec"
alias di="docker images"

# kube 
alias kc=kubectl
alias mk=minikube
alias g=gcloud
alias h=helm
alias hid="helm install --debug --dry-run"
alias hi="helm install"
alias hd="helm delete"
alias hl="helm ls"
alias hdu="helm dependency update"

# ruby
alias ber="bundle exec rspec"

# ssh aliases
touch ~/projects/dotfiles/.ssh_aliases
source ~/projects/dotfiles/.ssh_aliases

# zsh
source ~/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=$HOME/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# Terraform
alias tf="terraform"

alias lzd="lazydocker"

# add aliases quick
alias a="vim ~/projects/dotfiles/zshrc"

# react native
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$ANDROID_HOME/platform-tools:$PATH

export PATH="$HOME/.local/bin:$PATH"

# Node: nvm's default version (~/.nvm/alias/default) on the PATH without loading nvm, which is slow.
_nvm_default=$(<"$HOME/.nvm/alias/default" 2>/dev/null)
_nvm_dirs=("$HOME"/.nvm/versions/node/v${_nvm_default#v}*(N/nOn))
(( ${#_nvm_dirs} )) && export PATH="${_nvm_dirs[1]}/bin:$PATH"
unset _nvm_default _nvm_dirs
alias claude='claude --dangerously-skip-permissions'

# Opens the three Timeline tabs in Ghostty: Claude, CPU, Todos.
alias timeline="timeline-open"

# The nvm command loads nvm on first use, so new shells stay fast.
export NVM_DIR="$HOME/.nvm"
nvm() {
  unset -f nvm
  [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
  nvm "$@"
}
