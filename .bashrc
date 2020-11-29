parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

pull_master() {
  local current=$(git rev-parse --abbrev-ref HEAD)
  gitc master
  gitp
  gitc ${current}
}

gitr() {
  pull_master
  git rebase master
}

gitri() {
  pull_master
  git rebase -i master
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

alias til="vim +'normal Go' +'r!date' ~/til"
alias issue="vim +'normal Go' +'r!date' ~/issue"
alias idea="vim +'normal Go' +'r!date' ~/idea"
alias blog="vim +'normal Go' +'r!date' ~/blog"
alias gitd="git branch -d"
alias gits="git status"
alias gitc="git checkout"
alias gitp="git pull"
export PATH=/opt/bin:$PATH
