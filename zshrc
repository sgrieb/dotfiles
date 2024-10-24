# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
alias reload="source ~/.zshrc"

# git
alias gcm="git commit -m"
alias gs="git status"
alias gp="git push"
alias ga="git add ."
alias gd="git diff"
alias gc="git checkout -- "

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

# eval "$(rbenv init -)"

export NVM_DIR="$HOME/.nvm"
  [ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# heroku autocomplete setup
HEROKU_AC_ZSH_SETUP_PATH=/Users/steve/Library/Caches/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# Terraform
alias tf="terraform"

alias lzd="lazydocker"

export AWS_DEFAULT_REGION=us-east-2
# add aliases quick
alias a="vim ~/projects/dotfiles/zshrc"
