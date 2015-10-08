module.exports = {
    sendMail: function(args, successCallback, failCallback) {
        cordova.exec(successCallback,
                     failCallback,
                     "BackgroundEmail",
                     "sendMail",
                     [args[0],
                      args[1],
                      args[2],
                      args[3],
                      args[4],
                      args[5],
                      args[6],
                      args[7],
                      args[8],
                      args[9],
                      successCallback, failCallback]);
    }
};

/*
 fromEmail = args[0];
 toEmail = args[1];
 ccEmail = args[2];
 bccEmail = args[3];
 relayHost = args[4];
 requiresAuth = args[5];
 login = args[6];
 password = args[7];
 subject = args[8];
 content = args[9];
 */