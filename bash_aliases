#!/bin/bash

function regex { gawk 'match($0,/'$1'/, ary) {print ary['${2:-'0'}']}'; }

# remind myself of a way much faster than find . -inum
function finode {
    readarray data <<< `rt debugfs -R "ncheck $1" /dev/sda5 2>/dev/null`
    for index in ${!data[@]}; do
        echo ${data[index]}
    done
}

function jq2csv {
  jq -rf $HOME/shared_scripts/json2csv.jq $@
}

VIM_CMD="mvim"

# vim but go to the line number if pasting from a stack trace
function v {
  local arg="$1"
  local file="${arg%%:*}"  # Removes line number and colon
  local line="${arg##*:}"  # Gets the part after the last colon
  
  if [[ $line =~ ^[0-9]+$ ]]; then
    $VIM_CMD +$line $file
  else
    $VIM_CMD $@
  fi
}
alias vf="v \$(fzf)"

alias bash_aliases='v ~/shared_conf/bash_aliases'
alias bashalias='v ~/shared_conf/bash_aliases'
alias vrc="v $HOME/.vimrc"
alias gvrc="v $HOME/.gvimrc"
alias zrc="$VIM_CMD $HOME/.zshrc"
alias omzconf="$VIM_CMD $HOME/.oh-my-zsh"

alias rgs="rg --no-heading --max-columns=150 $@"
alias rgsi="rg --no-heading --max-columns=150 --ignore-case $@"
alias n="v $HOME/notes.md"
alias ff="find . -maxdepth 1000 * | fzf --sync | v -o"

# TW cd's
alias cdr="cd \$(git rev-parse --show-toplevel)" # cd to git root
alias cdt="cd $HOME/triplewhale"
alias cdb="cd $HOME/triplewhale/backend"
alias cdp="cd $HOME/triplewhale/packages"
alias cdc="cd $HOME/triplewhale/client"
alias cdd="cd $HOME/triplewhale/devops"
alias cdf="cd $HOME/triplewhale/triplewhale-fetchers"
alias cda="cd $HOME/triplewhale/ai"
alias cdx="cd $HOME/triplewhale/triple-print-js"
alias cdbs="cd $HOME/triplewhale/backstage"
alias cdad="cd $HOME/triplewhale/admin"

# Git
alias g="git $@"
alias ga="git add ."
alias gbd="git branch --delete $@"
alias gc="git checkout $@"
alias gd="git difftool"
alias gdh="git difftool HEAD"
alias gds="git difftool --staged"
alias gdm="git difftool origin/master"
alias gp="git pull $@"
alias gs="git status"
alias gmm="git merge origin/master"
alias gpsu="git push --set-upstream origin \$(current_branch)"
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --date=local"
alias gci="git commit -m"
alias gca="git add . && git commit -m $@"

alias lg="lazygit"

# Zed

alias z="/usr/local/bin/zed $@"

# ls
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# random
alias k="kubectl $@"

alias btoa="echo $@ | base64 -d"
