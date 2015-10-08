#import <Cordova/CDV.h>
#import <CFNetwork/CFNetwork.h>
#import "./SMTPLibrary/SKPSMTPMessage.h"
#import "./SMTPLibrary/NSData+Base64Additions.h"

@interface BackgroundEmail <SKPSMTPMessageDelegate> : CDVPlugin
    - (void)sendMail:(CDVInvokedUrlCommand*)command;

@end