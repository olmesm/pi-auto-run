const webdriver = require('selenium-webdriver');
const firefox = require('selenium-webdriver/firefox')

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

// https://seleniumhq.github.io/selenium/docs/api/javascript/module/selenium-webdriver/firefox/index.html

let profile = new firefox.Profile();
profile.addExtension('./addon/r_kiosk-0.9.0-fx.xpi');

let options = new firefox.Options()
  // .setBinary('/my/firefox/install/dir/firefox-bin'); // Different binary
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
