export PATH=$PATH

parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\u@\h \W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "
alias til="vim +'normal Go' +'r!date' ~/til"
alias issue="vim +'normal Go' +'r!date' ~/issue"
alias idea="vim +'normal Go' +'r!date' ~/idea"
alias blog="vim +'normal Go' +'r!date' ~/blog"
