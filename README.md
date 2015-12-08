# Background Email
An attempt of creating a cordova plugin that sends an email in the background.

**This plugin uses a library created by [@jetseven.](https://github.com/jetseven/skpsmtpmessage)**
  
  
##Install
  $ cordova plugin add https://github.com/rqroz/background-email.git

##Set up:
**1. Disable Objective-C Automatic Reference Counting for plugin files**
  - Your Project -> Build Phases -> Compile Sources
  - Select all the files related to this plugin (see src/ios) in there and press Enter.
  - Then type -fno-objc-arc as the compiler flag for those files to disable Objective-C Automatic Reference Counting.

**2. ADD CFNetwork.framework to your project**
  - Your Project -> Build Phases -> Link Binary With Libraries -> Add Library ( + ) -> CFNetwork

##Tips
####Delay
  The connection between your device and the server you're using may be slow depending on a number of factors (internet speed, trafic, etc), which delays the response. If you do not specify a port, for example, it might take up to 1 minute for the result (either successful or not) to be received. Therefore, it is nice to put a loading screen or something similar so the user doesn't think nothing is happening.
####Usage
  For to, cc & bcc fields, if you want to include more than one email just declare it as a string such as:
  
  "email1@domain1.com, email2@domain2.com, email3@domain3.com"
  

##Important

  The plugin is still in its development stage. While testing it with a fairly complex app, I run through a case where I would send an email but would not not get any response. Then if I put the app in the background and come back to it later it wouldcrash. For now I installed [katzer's plugin](https://github.com/katzer/cordova-plugin-background-mode) and enabled background mode, which seemed to have solved the problem. Therefore, if something similar happens to you I would tell you to do the same for now.

##Instantiating:
The plugin is not ready until deviceready event occurs.
```JavaScript
      var autoEmail = "";
      document.addEventListener('deviceready', onDeviceReady, false);
      function onDeviceReady(){
        autoEmail = window.background.Email;
      }
```

##Sending Email:
  ```javascript
      var emailObject = {
        from: "yourID@yourDomain.com", //your email
        to: "destinationID@destinationDomain.com", //the destination email
        cc: "ccID@ccDomain.com", //cc email
        bcc: "bccID@bccDomain.com", //bcc email
        subject: "Some Subject", //Subject
        body: "Some Message", //Body message
        login: "yourID@yourDomain.com", //Same as "from" (for some cases just 'yourID' is necessary)
        password: "yourPassword", //Your email's password
        relayHost: "some.smtp.server", //Ex: "smtp.google.com"
        port: [arrayOfIntegers], //Valid ports are 25, 465, and 587. Ex: [25, 587]
        //If you don't know what port your server uses, don't use this attribute
        auth: booleanValue1, //True or false for if the server requires authentication
        security: booleanValue2, //True or false
        SSL: booleanValue3 //Accepts true or false and stands for SSL Chain Validation
      };
      
      var success = function(){
        alert("Email sent!");
      }
      
      var failure = function(error){
        alert(error);
      }
      
      autoEmail.send(emailObject, success, failure);
```

##Final Comments
  Email me and let me know if something odd happens: ryu-shi@hotmail.com.
      
  Thanks! :)  
