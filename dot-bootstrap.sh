#!/usr/bin/env bash
set -e

tags="$1"

if [ -z $tags ]; then
  tags="all"
fi


DOT_DIR="${HOME}/.dotfiles"
if ! [ -d "$DOT_DIR" ]; then
  # Take action if $DOT_DIR exists. #
  echo "Creating ~.dotfiles directory as it doesn't exist ${DOT_DIR}..."
fi

if ! [ -x "$(command -v ansible)" ]; then
  sudo apt update
  sudo apt install ansible
fi

INSTALL_DIR=`pwd`
echo "Installing config files in ${DOT_DIR}..."
sudo cp ${INSTALL_DIR}/roles/git/files/gitignore_global.link ${DOT_DIR}/.
sudo cp ${INSTALL_DIR}/roles/bash/files/alias ${DOT_DIR}/.

# ansible-galaxy collection install community.general

ansible-playbook -i ${INSTALL_DIR}/hosts ${INSTALL_DIR}/dotfiles.yml --ask-become-pass --tags $tags

if command -v terminal-notifier 1>/dev/null 2>&1; then
  terminal-notifier -title "dotfiles: Bootstrap complete" -message "Successfully set up dev environment."
fi
