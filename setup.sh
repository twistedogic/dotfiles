#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.my_dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc config tmux.conf profile_alias config/nvim"    # list of files/folders to symlink in homedir

##########

git clone https://github.com/twistedogic/dotfiles $dir

if [ "$OSTYPE" == "linux-gnu"* ]; then
    sudo apt update
    sudo apt-get install --no-install-recommends -y nodejs npm neovim curl build-essential golang-go
    curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh -s -- -y
elif [ "$OSTYPE" == "darwin"* ]; then
    brew install neovim
fi

# create dotfiles_old in homedir
echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p $olddir
echo "...done"

# change to the dotfiles directory
echo "Changing to the $dir directory"
cd $dir
echo "...done"

backup() {
  local file=$1
  if [[ -f ".$file" ]]; then
    mv ~/.$file ~/dotfiles_old/
  fi
}

# move any existing dotfiles in homedir to dotfiles_old directory, then create symlinks 
for file in $files; do
  echo "Moving .$file from ~ to $olddir"
  backup $file
  echo "Copy .$file to ~"
  cp -r $dir/.$file ~/.$file
done

if [ -f ".zshenv" ]; then
  backup zshenv 
  echo "source ~/.bashrc" >> ~/.zshenv
fi

if [ -f ".zshrc" ]; then
  backup zshrc
  echo "source ~/.profile_alias" >> ~/.zshrc
  echo "source ~/.profile" >> ~/.zshrc
fi

rm -rf $dir
