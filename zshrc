
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
source "./projects/dotfiles/.ssh_aliases"
