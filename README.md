# Auto Browse

Runs through Jira Boards using a Raspberry Pi.

## Features

* Easily set Jira Login.
* Setup Script Included (See below).
* Single JSON file to set tasks/pages and period to view.


## To Setup and Run

Please look at the included setup script and understand the steps prior to running.

Run the following on a new installation of Raspbian:

```
wget -qO- https://raw.githubusercontent.com/olmesm/pi-auto-run/master/setup.sh | bash
```


## Todo

* Check Selenium needs fix ./node_modules/selenium-webdriver/lib/webdriver.js#2189
* Webserver to change login and tasks.
* Publish IP address of pi for SSH on top right corner of JIRA page.
* File for Wifi Settings.
* Store all settings on boot partition to easily access via SD.
* Create JS Scroll feature so all stories/tickets can be seen.
  - Possibly remove timer then or have timer only expire once scrolled.

<!--
May no longer require this with latest Selenium.

./node_modules/selenium-webdriver/lib/webdriver.js

```js
// 2189 from
setParameter('text', keys).
// to
setParameter('text', keys.then(keys => keys.join(''))).
```

https://github.com/SeleniumHQ/selenium/commit/6907a129a3c02fe2dfc54700137e7f9aa025218a
http://www.mantonel.com/tutorials/web-scraping-raspberry-pi-and-python

-->

## Resources

* [Selenium Webdriver >2 doesn't work](http://www.mantonel.com/tutorials/web-scraping-raspberry-pi-and-python)
* [Selenium Firefow Webdirver Client Setup](https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/firefox/index.html)
