module.exports = {
  'Demo test' : function (browser) {
    browser
      .url('http://192.168.83.240:8080/')
      .waitForElementVisible('body', 1000)
      .assert.containsText('body', 'Hello world')
      .end();
  }
};