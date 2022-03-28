source ~/.profile_alias

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

export PATH=/opt/bin:$HOME/go/bin:$PATH
