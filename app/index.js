require('geckodriver');

const webdriver = require('selenium-webdriver');
const firefox = require('selenium-webdriver/firefox')
const requireUncached = require('./require-uncached');
const config = require('../config');

let tasks = requireUncached('../tasks');

const By = webdriver.By;
const until = webdriver.until;
let count = 0;
let i = 0;

// https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/firefox/index.html

let profile = new firefox.Profile();
profile.addExtension('./addon/r_kiosk-0.9.0-fx.xpi');

let options = new firefox.Options()
  .setProfile(profile);

const driver = new webdriver.Builder()
  .forBrowser('firefox')
  .setFirefoxOptions(options)
  .build();

driver.manage().window().maximize()

function doLogin() {
  return driver.findElement(By.id('login-form-username')).sendKeys(config.login)
  .then(res => driver.findElement(By.id('login-form-password')).sendKeys(config.password))
  .then(res => driver.findElement(By.name('login')).click());
}

function runWeb(url, msec) {
  const sec = msec * 1000;

  driver.get(url)
    .then(res => driver.findElements(By.id('login-form-username')))
    .then(res => res.length >= 1 ? doLogin() : {})
    // Scroll through the page slowly
    .then(res => driver.executeScript(`
      setInterval(
        function() {
          document.getElementById('ghx-pool').scrollTop +=1;
        }, 200);
      `))
    .then(res => setTimeout(incrementCounter, sec))
}

function loopDeLoop() {
  let current = tasks[i];
  console.log('running', current.name);
  runWeb(current.url, current.sec);
}

function incrementCounter() {
  i++;

  if (i === tasks.length) {
    tasks = requireUncached('./tasks');
    i = 0;
  }

  loopDeLoop();
}

loopDeLoop();
