#! /bin/sh

# Get script location
CURRENT_DIR=$(dirname $0)

# Install deps

apt-get update
apt-get install -y vim iceweasel git

# Delete previous configs and make a new dir
rm -rf /boot/auto-run*
mkdir /boot/auto-run

# Copy configs to boot dir
cat $CURRENT_DIR/configs/tasks.json > /boot/auto-run/tasks.json
cat $CURRENT_DIR/configs/jira-login.json > /boot/auto-run/jira-login.json

# Setup Wifi
cat $CURRENT_DIR/configs/SETTING-UP-WIFI.md > /boot/auto-run/SETTING-UP-WIFI.md
cat $CURRENT_DIR/configs/example_wifi.config > /boot/auto-run/example_wifi.config

# Add Startup Script
cat $CURRENT_DIR/configs/startup.sh > /boot/auto-run/startup.sh
chown root:root /boot/auto-run/startup.sh
chmod ug+x /boot/auto-run/startup.sh

echo "

## Added for auto-run

sh /boot/auto-run/startup.sh &" >> /etc/rc.local

# Setup Node

echo "
##################################################

Please setup node by running the following:

sh $CURRENT_DIR/configs/setup-node.sh


!!!NB:
    DO NOT INSTALL WITH SUDO

##################################################
" 