
# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
alias reload="source ~/.bash_profile"

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

# sb
alias sb="ssh steve@10.0.0.154 -p 27595"
alias sbh="ssh steve@192.168.1.190 -p 27595"
alias sbr="ssh steve@71.225.12.117 -p 27595"

# sb-copy scp -P 27595 adam_openvpn.zip steve@10.0.0.154:/home/steve

# ssh 27595
# ftp 46412
