#import "BackgroundEmail.h"
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@implementation BackgroundEmail

    -(void)pluginInitialize{

    }

    - (void)sendMail:(CDVInvokedUrlCommand*)command
    {
        SKPSMTPMessage *email = [[SKPSMTPMessage alloc] init]
        email.fromEmail = [command argumentAtIndex:0];
        email.toEmail = [command argumentAtIndex:1];
        email.ccEmail = [command argumentAtIndex:2];
        email.bccEmail = [command argumentAtIndex:3];
        email.relayHost = [command argumentAtIndex:4];
        email.requiresAuth = [command argumentAtIndex:5];
        email.login = [command argumentAtIndex:6];
        email.pass = [command argumentAtIndex:7];
        email.subject = [command argumentAtIndex:8];
        email.wantsSecure = YES;
        email.delegate = self;
        
        NSDictionary *actualMessage = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain", kSKPSMTPPartContentTypeKey, [command argumentAtIndex:9], kSKPSMTPPartMessageKey, @"8bit", kSKPSMTPPartContentTransferEncodingKey, nil];
        email.parts = [NSArray arrayWithObjects:actualMessage, nil];
        [email send];
        
        /*
        if (myarg != nil) {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
        } else {
            pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
        }
        [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
        */
    }

-(void)messageSent:(SKPSMTPMessage *)message{
    NSLog(@"Message Sent!");
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    NSLog(@"Message Failed");
    CDVPluginResult* pluginResult =[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
}

@end