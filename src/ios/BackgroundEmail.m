#import "BackgroundEmail.h"
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@interface BackgroundEmail() <SKPSMTPMessageDelegate>
@end


@implementation BackgroundEmail: CDVPlugin
    @synthesize callbackID;
    -(void)pluginInitialize{

    }

    - (void)sendEmail:(CDVInvokedUrlCommand*)command
    {
        [self.commandDelegate runInBackground:^{
            SKPSMTPMessage *email = [[SKPSMTPMessage alloc] init];
            @try {
                self.callbackID = command.callbackId;
                email.fromEmail = [command argumentAtIndex:0];
                email.toEmail = [command argumentAtIndex:1];
                email.subject = [command argumentAtIndex:2];
                email.login = [command argumentAtIndex:4];
                email.pass = [command argumentAtIndex:5];
                email.relayHost = [command argumentAtIndex:6];
                email.requiresAuth = YES;
                email.wantsSecure = YES;
                email.validateSSLChain = [[command argumentAtIndex:8] boolValue];
                email.delegate = self;
                
                NSInteger port = [[command argumentAtIndex:7] integerValue];
                if(port != 0){
                    email.relayPorts = [[NSArray alloc] initWithObjects:[NSNumber numberWithShort:port], nil];
                }
                
                NSString *bodyMessage = [command argumentAtIndex:3];
                NSDictionary *actualMessage = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain", kSKPSMTPPartContentTypeKey, bodyMessage, kSKPSMTPPartMessageKey, @"8bit", kSKPSMTPPartContentTransferEncodingKey, nil];
                email.parts = [NSArray arrayWithObjects:actualMessage, nil];
                
                [email send];
            }
            @catch (NSException *exception) {
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception description]];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
            }
        }];
    }

    -(void)messageSent:(SKPSMTPMessage *)message{
            @try {
                /*
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SMTP Email" message:@"Email Sent!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
                */
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Message sent!"];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
            }
            @catch (NSException *exception) {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SMTP Email" message:[exception description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
    }

    -(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
            @try{
                NSString *errorMsg = [NSString stringWithFormat:@"%@\n%@", [error localizedDescription], [error localizedRecoverySuggestion]];
                CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorMsg];
                [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
            }
            @catch(NSException *exception){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"SMTP Email" message:[exception description] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                [alert show];
            }
    }

@end
