#! /bin/bash

sudo mv $BOOT_DIR/$REPO_NAME/wifi.config /etc/wpa_supplicant/wpa_supplicant.conf
sleep 5
sudo wpa_cli reconfigure
