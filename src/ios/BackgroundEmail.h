#import <Cordova/CDV.h>
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@interface BackgroundEmail <SKPSMTPMessageDelegate> : CDVPlugin
  @property(strong) NSString* callbackID;
  -(void)sendEmail:(CDVInvokedUrlCommand*)command;
@end
