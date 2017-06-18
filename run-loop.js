const chromedriver = require('chromedriver');
const webdriver = require('selenium-webdriver');
const chrome = require('selenium-webdriver/chrome');

function requireUncached(module){
  delete require.cache[require.resolve(module)]
  return require(module)
}

let tasks = requireUncached('./tasks');
let config = require('./config');

const By = webdriver.By;
const until = webdriver.until;
let count = 0;
let i = 0;

const options = new chrome.Options();
options.setUserPreferences( { enable_do_not_track: true } );
options.addArguments(
  '--incognito',
  '--kiosk',
  'disable-infobars',
  '--app=https://google.com'
);
options.setChromeBinaryPath('/usr/local/bin/chromium');

const driver = new webdriver.Builder()
  .forBrowser('chrome')
  .setChromeOptions(options)
  .build();

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
