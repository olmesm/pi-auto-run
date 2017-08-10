#! /bin/bash

########################################
# Setup Variables

BOOT_DIR="/boot"
REPO_NAME="pi-auto-run"
REPO="https://github.com/olmesm/$REPO_NAME.git"
REBOOT_TIME=60

########################################
# Go to Home dir
cd


########################################
# Setup Firefox

sudo apt-get update
sudo apt-get install iceweasel git -y


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
cd $REPO_NAME


########################################
# Setup Required Packages

## NPM Install
npm install


########################################
# Fix Selenium

# sed -i '' -e "s/setParameter('text', keys)./setParameter('text', keys.then(keys => keys.join('')))./" ./node_modules/selenium-webdriver/lib/webdriver.js


########################################
# Create Required Files

sudo mkdir -p $BOOT_DIR/$REPO_NAME

# Make Tasks.json and jira-config.json

sudo ./scripts/_setup-boot-files.sh

## Add to path

echo "

export BOOT_DIR=$BOOT_DIR
export REPO_NAME=$REPO_NAME" >> ~/.bashrc

source .bashrc


########################################
# Finish Setup Raspbian

sudo ./scripts/_setup-ssh.sh

# Set overscan/HDMI
# Setup WIFI

sudo ./scripts/_setup-wifi.sh

# Startup script
echo "
sleep 5
~/$REPO_NAME/scripts/startup.sh
" >> ~/.bashrc


########################################
# Run

echo "
########################################
Completed.

To Start:
$ npm start

To add/edit/remove tasks:
$ vim $BOOT_DIR/$REPO_NAME/tasks.json

To add/edit/remove Jira Login details:
$ vim $BOOT_DIR/$REPO_NAME/jira-config.json

To add/edit/remove wifi Login details:
$ vim $BOOT_DIR/$REPO_NAME/wifi.config

Will auto-reboot this device in $REBOOT_TIME seconds.
"

sleep $REBOOT_TIME
sudo reboot
