cordova.define("com-spmt-rqueiroz-BackgroundEmail.BackgroundEmail", function(require, exports, module) {
  module.exports = {
    send: function(emailObj, successCallback, failCallback) {
      cordova.exec(
        successCallback,
        failCallback,
        "BackgroundEmail",
        "sendEmail",
        [
          emailObj.from,
          emailObj.to,
          emailObj.subject,
          emailObj.body,
          emailObj.login,
          emailObj.password,
          emailObj.relayHost,
          emailObj.port
        ]
      );
    }
  };
});
