#! /bin/bash

########################################
# Setup Variables

BOOT_DIR="/boot"
REPO_NAME="pi-auto-run"
REPO="git@github.com:olmesm/$REPO_NAME.git"
REBOOT_TIME=60

########################################
# Go to Home dir
cd


########################################
# Setup Firefox

sudo apt-get update
sudo apt-get install firefox git -y


########################################
# Setup Node

## Download NVM
wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.33.2/install.sh | bash

## Add to shell
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh" # This loads nvm

## Get Node
nvm install 7
nvm use 7 --default

## Add Node Modules to path

echo '
PATH="./node_modules/.bin:$PATH"' >> ~/.bashrc

source .bashrc

########################################
# Clone Repo

git clone $REPO
cd $REPO


########################################
# Setup Required Packages

## NPM Install
npm install


########################################
# Fix Selenium

# sed -i '' -e "s/setParameter('text', keys)./setParameter('text', keys.then(keys => keys.join('')))./" ./node_modules/selenium-webdriver/lib/webdriver.js


########################################
# Create Required Files

mkdir -p $BOOT_DIR/$REPO_NAME

# may need to sudo then chown ^^^

echo '
[
  {
    "name": "Example 1",
    "url": "https://google.com",
    "sec": 10
  },
  {
    "name": "Example 2",
    "url": "https://jira.com",
    "sec": 10
  }
]
' > $BOOT_DIR/$REPO_NAME/tasks.json

echo '
{
  "login": "user-login",
  "password": "user-password"
}
' > $BOOT_DIR/$REPO_NAME/config.json

## Add to path

echo "
export BOOT_DIR=$BOOT_DIR
export REPO_NAME=$REPO_NAME" >> ~/.bashrc

source .bashrc


########################################
# Finish Setup Raspbian

touch $BOOT_DIR/ssh
# Set overscan/HDMI
# Setup WIFI
# Setup npm start on boot


########################################
# Run

echo "
########################################
Completed.

To Start:
$ npm start

To add/edit/remove tasks:
$ vim $BOOT_DIR/$REPO_NAME/tasks.json

To add/edit/remove Login details (Jira tested only):
$ vim $BOOT_DIR/$REPO_NAME/config.json

Will auto-reboot this device in $REBOOT_TIME seconds.
"

sleep $REBOOT_TIME
sudo reboot
