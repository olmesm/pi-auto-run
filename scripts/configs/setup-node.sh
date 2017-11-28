#! /bin/sh

# Get NVM - easiest way to get woring node binaries on pi
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

## Add to shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

## Get Node
nvm install 7
nvm use 7 --default