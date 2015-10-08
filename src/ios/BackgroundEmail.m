#import "BackgroundEmail.h"
#import <CFNetwork/CFNetwork.h>
#import "./SMTPLibrary/SKPSMTPMessage.h"
#import "./SMTPLibrary/NSData+Base64Additions.h"

@implementation BackgroundEmail

    -(void)pluginInitialize{

    }

    - (void)sendMail:(CDVInvokedUrlCommand*)command
    {
        NSString* fromEmail = [command argumentAtIndex:0];
        NSString* toEmail = [command argumentAtIndex:1];
        NSString* ccEmail = [command argumentAtIndex:2];
        NSString* bccEmail = [command argumentAtIndex:3];
        NSString* relayHost = [command argumentAtIndex:4];
        NSString* requiresAuth = [command argumentAtIndex:5];
        NSString* login = [command argumentAtIndex:6];
        NSString* password = [command argumentAtIndex:7];
        NSString* subject = [command argumentAtIndex:8];
        NSString* content = [command argumentAtIndex:9];
        
        NSDictionary *actualMessage = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain", kSKPSMTPPartContentTypeKey, content, kSKPSMTPPartMessageKey, @"8bit", kSKPSMTPPartContentTransferEncodingKey, nil];
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