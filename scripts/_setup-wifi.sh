#! /bin/bash

echo '
# Setup Wifi

Go to <https://www.raspberrypi.org/documentation/configuration/wireless/wireless-cli.md>

' > $BOOT_DIR/$REPO_NAME/SETTING-UP-WIFI.md

echo '
network={
    ssid="testing"
    psk="testingPassword"
}
' > $BOOT_DIR/$REPO_NAME/wifi.config
