require('chromedriver');
var webdriver = require('selenium-webdriver'),
    By = webdriver.By,
    until = webdriver.until;

let credentials = require('./credentials');

var chrome = require('selenium-webdriver/chrome');
var chromeCapabilities = webdriver.Capabilities.chrome();
var options = new chrome.Options();
options.setUserPreferences( { enable_do_not_track: true } );
options.addArguments('--incognito', '--kiosk', 'disable-infobars', '--app=https://google.com');

var driver = new webdriver.Builder()
    .forBrowser('chrome')
    .setChromeOptions(options)
    .build();

var count = 1;

function doLogin() {
  return driver.findElement(By.id('login-form-username')).sendKeys(credentials.login)
  .then(res => driver.findElement(By.id('login-form-password')).sendKeys(credentials.password))
  .then(res => driver.findElement(By.name('login')).click());
}

function loopDeLoop() {
  driver.get('https://jira.andigital.com/secure/RapidBoard.jspa?rapidView=265&projectKey=AW')
    .then(res => driver.findElements(By.id('login-form-username')))
    .then(res => res.length >= 1 ? doLogin() : console.log('count: ', count++))
    .then(res => setTimeout(loopDeLoop, 5000))
}

loopDeLoop();

// function waitThenQuit() {
//   // driver.quit();
//   count ++;
//   console.log('>> count', count);
//   loopDriver();
// }

// function waitOnLogin() {
//   var isLoginPage = driver.findElements(By.id('login-form-username'))

//   if (driver.findElements(By.id('login-form-username')).length >= 1) {
//     driver.findElement(By.id('login-form-username')).sendKeys(credentials.login);
//     driver.findElement(By.id('login-form-password')).sendKeys(credentials.password);

//     driver.findElement(By.name('login')).click()
//       .then(() => {
//         setTimeout(waitThenQuit, 1000);
//       });
//   }
// }

// function loopDriver() {
//   // console.log(driver.findElements(By.id('login-form-username')).size !== 0);
//   driver.get('https://jira.andigital.com/secure/RapidBoard.jspa?rapidView=265&projectKey=AW').then(() => {
//     setTimeout(waitOnLogin, 1000);
//   });
//   // console.log('>> find res', driver.findElement(By.id('login-form-username')));
//   // console.log('moved on')



// }

// loopDriver();
