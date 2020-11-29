#!/bin/bash
############################
# .make.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir=~/.my_dotfiles                    # dotfiles directory
olddir=~/dotfiles_old             # old dotfiles backup directory
files="bashrc vimrc vimrc.bundles vimrc.plugins config"    # list of files/folders to symlink in homedir

##########

git clone https://github.com/twistedogic/dotfiles $dir

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

if [[ -f ".zshenv" ]]; then
  backup zshenv 
  echo "source ~/.bashrc" >> ~/.zshenv
fi

rm -rf $dir
