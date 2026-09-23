#!/bin/bash
set -euo pipefail

############################
# setup.sh
# Symlinks dotfiles from this repo into $HOME. Idempotent.
############################

########## Variables

dir="$HOME/.my_dotfiles"
olddir="$HOME/dotfiles_old"
files=("bashrc" "config" "tmux.conf" "profile_alias")

##########

# Ensure git is available
if ! command -v git >/dev/null 2>&1; then
  case "$OSTYPE" in
    darwin*)  brew install git ;;
    linux*)   sudo apt-get update && sudo apt-get install -y git ;;
  esac
  hash -r
fi

# Idempotent clone: pull if present, otherwise clone fresh
if [ -d "$dir/.git" ]; then
  git -C "$dir" pull --ffonly --autostash
else
  rm -rf "$dir"
  git clone https://github.com/twistedogic/dotfiles "$dir"
fi

# Install mise if missing
MISE_BIN="$HOME/.local/bin/mise"
if [ ! -x "$MISE_BIN" ]; then
  curl https://mise.run | sh
fi

# Activate mise for the rest of this script
eval "$("$MISE_BIN" activate bash)"
hash -r

# Enable backends used below (idempotent; auto-installs if missing)
mise plugins install aqua github 2>/dev/null || true

mise use -g node@latest
mise use -g go@latest
mise use -g uv@latest
mise use -g tmux@latest
mise use -g jq@latest
mise use -g gh@latest
mise use -g neovim@0.11.6
mise use -g github:charmbracelet/gum
mise use -g aqua:go-task/task@latest
mise use -g npm:@fission-ai/openspec npm:@getpaseo/cli

# Append a line to a file only if not already present
append_once() {
  grep -qF -- "$2" "$1" 2>/dev/null || printf '%s\n' "$2" >> "$1"
}

# Link each dotfile, moving any pre-existing non-symlink aside first
backup_and_link() {
  local file=$1
  if [ -e ~/."$file" ] && [ ! -L ~/."$file" ]; then
    mkdir -p "$olddir"
    mv ~/."$file" "$olddir/"
  fi
  ln -sfn "$dir/.$file" ~/."$file"
}

for file in "${files[@]}"; do
  backup_and_link "$file"
done

# Shell integration (idempotent)
[ -f ~/.zshenv ] && append_once ~/.zshenv "source ~/.bashrc"
[ -f ~/.zshrc  ] && append_once ~/.zshrc  "source ~/.profile_zsh"

case "$OSTYPE" in
  linux*)   append_once ~/.bashrc 'eval "$(~/.local/bin/mise activate bash)"' ;;
  darwin*)  append_once ~/.zshrc  'eval "$(~/.local/bin/mise activate zsh)"'  ;;
esac

curl -fsSL https://pkg.lightpanda.io/install.sh | bash

mise x -- npm i -g --ignore-scripts @earendil-works/pi-coding-agent
mise x -- npx @fission-ai/openspec@latest init --tools pi
mise x -- npx skills add https://github.com/github/awesome-copilot \
    --skill git-commit -g -a universal -y
mise x -- npx skills add https://github.com/mattpocock/skills \
    --skill grilling \
    --skill tdd \
    --skill teach \
    --skill to-spec \
    --skill writing-for-agents \
    --skill wait-what \
    -g -a universal -y

pi install npm:pi-mcp-adapter
pi install git:github.com/DietrichGebert/ponytail
