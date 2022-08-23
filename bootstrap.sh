#!/usr/bin/env bash

cd "$(dirname "${BASH_SOURCE}")";

#git pull origin main;

# curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh

function doIt() {
  rsync --exclude ".git/" \
    --exclude ".DS_Store" \
    --exclude ".osx" \
    --exclude "bootstrap.sh" \
    --exclude "README.md" \
    --exclude "LICENSE-MIT.txt" \
    -avh --no-perms . ~;
  if ! command -v brew &> /dev/null; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/kbcaleb/.zprofile
    eval export "$(/opt/homebrew/bin/brew shellenv)"
  fi;
  source ~/.zprofile;
}

if [ "$1" = "--force" -o "$1" = "-f" ]; then
  doIt;
else
  read "?This may overwrite existing files in your home directory. Are you sure? (y/n) ";
  echo "";
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    doIt;
  fi;
fi;
unset doIt;
