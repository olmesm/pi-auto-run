# Auto Browse

```bash
npm i
```

./node_modules/selenium-webdriver/lib/webdriver.js

```js
// 2189 from
setParameter('text', keys).
// to
setParameter('text', keys.then(keys => keys.join(''))).
```

https://github.com/SeleniumHQ/selenium/commit/6907a129a3c02fe2dfc54700137e7f9aa025218a
