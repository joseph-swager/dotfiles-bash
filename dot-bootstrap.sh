#!/usr/bin/env bash
set -e
declare _tags _installDir _homeDotDir

_tags="$1"

if [ -z $_tags ]; then
  _tags="all"
fi


_homeDotDir="${HOME}/.dotfiles"
if ! [ -d "$_homeDotDir" ]; then
  # Take action if $DOT_DIR exists. #
  echo "Creating ~.dotfiles directory as it doesn't exist ${_homeDotDir}..."
fi

if ! [ -x "$(command -v ansible)" ]; then
  sudo apt update
  sudo apt install ansible
fi

_installDir=`pwd`
echo "Installing config files in ${_homeDotDir}..."
sudo cp ${_installDir}/roles/git/files/gitignore_global.link ${_homeDotDir}/.

# ansible-galaxy collection install community.general

ansible-playbook -i ${_installDir}/hosts ${_installDir}/dotfiles.yml --ask-become-pass --tags $_tags

if command -v terminal-notifier 1>/dev/null 2>&1; then
  terminal-notifier -title "dotfiles: Bootstrap complete" -message "Successfully set up dev environment."
fi
