#!/bin/bash

# This script installs the dotfiles locally. Note that it should be run from the
# dotfiles folder so that the links are set properly!

function bannerSimple() {
  local msg="${2} ${1} ${2}"
  local edge
  edge=${msg//?/$2}
  echo "${edge}"
  echo "$(tput bold)${msg}$(tput sgr0)"
  echo "${edge}"
  echo
}

bannerSimple "kr40's Bash DotFiles Installer" "*"

echo "Moving already existing .bashrc, .bash_aliases and .gitconfig to bashrc.bak, bashaliaes.bak and gitconfig.bak"

# Rename the existing bashrc and bash_aliases files.
mv "$HOME/.bashrc" "$HOME/bashrc.bak" >>/dev/null 2>&1
mv "$HOME/.bash_aliases" "$HOME/bash_aliases.bak" >>/dev/null 2>&1
mv "$HOME/.gitconfig" "$HOME/gitconfig.bak" >>/dev/null 2>&1

echo "Symlinking alises.sh, bashrc.sh and gitconfig to .bashrc, .bash_aliases and .gitconfig"

# Create links for the shell configuration.
ln -sf "$PWD/aliases.sh" "$HOME/.bash_aliases"
ln -sf "$PWD/bashrc.sh" "$HOME/.bashrc"
ln -sf "$PWD/gitconfig" "$HOME/.gitconfig"

echo "Successfully installed dotfiles!"
echo "Read system-setup for further information."

echo "Restart your terminal to see the changes!"
