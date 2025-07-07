#!/usr/bin/env bash

# TODO: add brew installation
#if ! [ -f /opt/homebrew/bin/brew ]; then
#fi

export PATH="/opt/homebrew/bin:$PATH"

brew update
brew upgrade

# Install brew packages
brew install \
  git \
  neovim \
  starship \
  sheldon \
  ripgrep \
  eza \
  asdf \
  kubectl \
  gh \
  watch \
  stern

# Install brew casks
brew install --cask \
  utm \
  spotify \
  kitty \
  firefox \
  1password \
  obsidian \
  nikitabobko/tap/aerospace \
  karabiner-elements \
  dropbox \
  logitech-g-hub \
  discord
