#!/bin/bash
set -euo pipefail

############################
# setup.sh
# This script creates symlinks from the home directory to any desired dotfiles in ~/dotfiles
############################

########## Variables

dir="$HOME/.my_dotfiles"
olddir="$HOME/dotfiles_old"
files=("bashrc" "config" "tmux.conf" "profile_alias" "config/nvim")

##########

if ! command -v git >/dev/null 2>&1; then
  case "$OSTYPE" in
    darwin*)  brew install git ;;
    linux-gnu*) sudo apt-get update && sudo apt-get install -y git ;;
  esac
fi

git clone https://github.com/twistedogic/dotfiles "$dir"

curl https://mise.run | sh

MISE_BIN="$HOME/.local/bin/mise"

$MISE_BIN use -g node@latest
$MISE_BIN use -g go@latest
$MISE_BIN use -g uv@latest
$MISE_BIN use -g tmux@latest
$MISE_BIN use -g jq@latest
$MISE_BIN use -g gh@latest
$MISE_BIN use -g neovim@0.11.6
$MISE_BIN use -g github:charmbracelet/gum
$MISE_BIN use -g aqua:go-task/task@latest

echo "Creating $olddir for backup of any existing dotfiles in ~"
mkdir -p "$olddir"
echo "...done"

echo "Changing to the $dir directory"
cd "$dir"
echo "...done"

backup() {
  local file=$1
  if [ -f ~/."$file" ]; then
    mv ~/."$file" "$olddir"/
  fi
}

for file in "${files[@]}"; do
  echo "Moving .$file from ~ to $olddir"
  backup "$file"
  echo "Copy .$file to ~"
  cp -r "$dir/.$file" ~/."$file"
done

if [ -f ~/.zshenv ]; then
  backup zshenv
  echo "source ~/.bashrc" >> ~/.zshenv
fi

if [ -f ~/.zshrc ]; then
  backup zshrc
  echo "source ~/.profile_zsh" >> ~/.zshrc
fi

case "$OSTYPE" in
  linux-gnu*)
    echo "eval \"\$(~/.local/bin/mise activate bash)\"" >> ~/.bashrc
    ;;
  darwin*)
    echo "eval \"\$(~/.local/bin/mise activate zsh)\"" >> ~/.zshrc
    ;;
esac

npm i -g --ignore-scripts @earendil-works/pi-coding-agent
npm i -g @fission-ai/openspec @getpaseo/cli

pi install npm:pi-mcp-adapter
pi install git:github.com/DietrichGebert/ponytail

curl -fsSL https://pkg.lightpanda.io/install.sh | bash

npx skills add https://github.com/github/awesome-copilot --skill git-commit -g
npx skills add https://github.com/github/awesome-copilot --skill gh-cli -g

rm -rf "$dir"
