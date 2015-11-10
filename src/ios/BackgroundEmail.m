#import "BackgroundEmail.h"
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@implementation BackgroundEmail
CDVInvokedUrlCommand* aux;
-(void)pluginInitialize{
    
}

- (void)send:(CDVInvokedUrlCommand*)command
{
    aux = command;
    SKPSMTPMessage *email = [[SKPSMTPMessage alloc] init];
    email.fromEmail = [command argumentAtIndex:0];
    email.toEmail = [command argumentAtIndex:1];
    email.relayHost = [command argumentAtIndex:2];
    email.requiresAuth = [command argumentAtIndex:3];
    email.login = [command argumentAtIndex:4];
    email.pass = [command argumentAtIndex:5];
    email.subject = [command argumentAtIndex:6];
    email.wantsSecure = [command argumentAtIndex:7];
    email.relayPorts = [[NSArray alloc] initWithObjects:[NSNumber numberWithShort:587], nil];
    email.validateSSLChain = NO;
    
    NSString *bodyMessage = [command argumentAtIndex:8];
    NSDictionary *actualMessage = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain", kSKPSMTPPartContentTypeKey, bodyMessage, kSKPSMTPPartMessageKey, @"8bit", kSKPSMTPPartContentTransferEncodingKey, nil];
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
    [self.commandDelegate sendPluginResult:pluginResult callbackId:aux.callbackId];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    NSLog(@"Message Failed");
    CDVPluginResult* pluginResult =[CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:@"Arg was null"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:aux.callbackId];
}

@end