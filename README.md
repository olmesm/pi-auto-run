# Auto-run

**NOTE** ~~This only works with [Raspbian Jessie](https://downloads.raspberrypi.org/raspbian/images/raspbian-2017-07-05/).~~


**NOTE** This now doesnt work with anything... Firefox got an update and has broken since iceweasel v38.

![Midnight Warrior](https://media.giphy.com/media/upztYklL3VhNm/giphy.gif)

Newer Versions on Raspbian use a version of firefox which is not compatible with Selenium/

# To Run

On your Pi

```sh
# Using a fresh install of Raspian Jessie
# https://www.raspberrypi.org/documentation/installation/installing-images/

# Boot up the pi and set the network to the same as your PC

# Using Pi Terminal
# Enable SSH
sudo touch /boot/ssh

# Reboot
sudo reboot
```

On your PC

```sh
# Clone this repo to your pc
git clone https://github.com/olmesm/pi-auto-run.git

# SSH into the pi and Create the required directories
ssh pi@raspberrypi 'mkdir app scripts' # password will be raspberry - dont change it yet

# Copy the relevant scripts and app across from local PC
scp -r ./app ./scripts pi@raspberrypi:~

# Setup the pi
ssh pi@raspberrypi 'sudo sh ~/scripts/setup.sh' 

# Setup NVM and Node
ssh pi@raspberrypi 'sh ~/scripts/configs/setup-node.sh'

# Setup the app
ssh pi@raspberrypi 'cd ~/app && npm i'

# You may need to fix Selenium error with the following command
# https://github.com/SeleniumHQ/selenium/commit/6907a129a3c02fe2dfc54700137e7f9aa025218a
ssh pi@raspberrypi 'cd ~/app && npm run fix'

# Run app
ssh pi@raspberrypi 'cd ~/app && npm start'
```

## Easy Access

I have designed the app to allow for easy changing of various credentials and tasks. They can either be chaged via the Pi, or by powering down the Pi and inserting the card into your SD card reader and changing the files there.

Mac and Windows can't read all the partions required for the Pi, but there is a `boot` partition that uses FAT filesystem. All the configurable files are located there - `/boot/auto-run/`.

Configs for the app that can be found in `/boot/auto-run/` are:

- Jira Tasks
- Jira Login Details
- Wifi Login Details

Please read the [Wifi Setup Instructions](./scripts/configs/SETTING-UP-WIFI.md)

## TODO

- Get Node Working with Selenium on the Pi
- Run script to start process

<!-- rsync -r -e ssh ./pi/scripts/ pi@raspberrypi:scripts -->