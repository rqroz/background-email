#import <Cordova/CDV.h>
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@interface BackgroundEmail <SKPSMTPMessageDelegate> : CDVPlugin
    - (void)sendMail:(CDVInvokedUrlCommand*)command;

@end