# Background Email
An attempt of creating a cordova plugin that can send an email in the background.

**This plugin uses a library created by [@jetseven.](https://github.com/jetseven/skpsmtpmessage)**
  
  
##Install
  $ cordova plugin add https://github.com/rqroz/background-email.git

##Set up:
Your Project -> Build Phases -> Compile Sources

Select all the files related to this plugin (see src/ios) in there and press Enter.

Then type -fno-objc-arc as the compiler flag for those files to disable Objective-C Automatic Reference Counting.

##Using:
The plugin is not ready until deviceready event occurs.
```JavaScript
      var autoEmail = "";
      document.addEventListener('deviceready', onDeviceReady, false);
      function onDeviceReady(){
        autoEmail = window.background.Email;
      }
```

##Sending Email:
  ```
      var emailObject = {
        from: "yourID@yourDomain.com",
        to: "destinationID@destinationDomain.com",
        subject: "Some Subject", //Subject for the email
        body: "Some Message", //body message for the email
        login: "yourID@yourDomain.com", //same as "from" (for some cases just 'yourID' is necessary)
        password: "yourPassword", //your email's password
        relayHost: "some.smtp.server", //ex: "smtp.google.com"
        port: somePortAsInteger //valid ports are 25, 465, or 587.
        //If you don't know what port it your server uses, delete this attribute completely
      };
      
      var success = function(){
        alert("Email sent!");
      }
      
      var failure = function(error){
        alert(error);
      }
      
      autoEmail.send(emailObject, success, failure);
```


##Tips
  
  The connection between your device and the server you're using may be slow depending on a number of factors (internet speed, trafic, etc), which delays the response. If you do not specify a port, for example, it might take up to 1 minute for the result (either successful or not) to be received. Therefore, it is nice to put a loading screen or something similar so the user doesn't think nothing is happening.
      
##Important

  As you may know by now, the plugin is still in its development stage. While testing it with a fairly complex app, I run through a case where I would send the email and do not receiveany response. Then if I put the app in the background and come back to it later it wouldcrash. For now I installed [katzer's plugin](https://github.com/katzer/cordova-plugin-background-mode) and enabled background mode. That seemed to solve the problem and now it is working fine with that app, so if something similar happens to you I would tell you to do the same for now.
      
  Other than that, I tested it with some pretty simple apps and they all worked fine for me. 
  Email me and let me know if something odd happens: ryu-shi@hotmail.com.
      
  Thanks! :)  
