# background-email
An attempt of creating a cordova plugin that can send an email in the background
This plugin uses a library created by @jetseven. 
  To check his library out go to https://github.com/jetseven/skpsmtpmessage
  
  
Install
  $ cordova plugin add https://github.com/rqroz/background-email.git

Set up:

Your Project -> Build Phases -> Compile Sources

Select all the files related to this plugin (see src/ios) in there and press Enter.

Then type -fno-objc-arc as the compiler flag for those files to disable Objective-C Automatic Reference Counting
  
Using:

The plugin is not ready until deviceready event occurs.

    Ex:
      var autoEmail = "";
      document.addEventListener('deviceready', onDeviceReady, false);
      function onDeviceReady(){
        autoEmail = window.background.Email;
      }
      
  Sending Email:
  
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
      
      
