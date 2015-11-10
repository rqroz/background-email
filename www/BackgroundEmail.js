cordova.define("com-spmt-rqueiroz-BackgroundEmail.BackgroundEmail", function(require, exports, module) {
               module.exports = {
                    send: function(emailObj, successCallback, failCallback) {
                        cordova.exec(successCallback,
                                     failCallback,
                                     "BackgroundEmail",
                                     "send",
                                     [
                                      emailObj.from,
                                      emailObj.to,
                                      emailObj.relayHost,
                                      emailObj.requiresAuth,
                                      emailObj.login,
                                      emailObj.password,
                                      emailObj.subject,
                                      emailObj.wantsSecure,
                                      emailObj.body
                                      ]
                        );
                    }
                };
});