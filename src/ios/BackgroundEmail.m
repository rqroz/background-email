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
                CDVInvokedUrlCommand *arguments = [command argumentAtIndex:0];
                email.fromEmail = [arguments valueForKey:@"from"];
                email.toEmail = [arguments valueForKey:@"to"];
                email.ccEmail = [arguments valueForKey:@"cc"];
                email.bccEmail = [arguments valueForKey:@"bcc"];
                email.subject = [arguments valueForKey:@"subject"];
                email.login = [arguments valueForKey:@"login"];
                email.pass = [arguments valueForKey:@"password"];
                email.relayHost = [arguments valueForKey:@"relayHost"];
                email.requiresAuth = [[arguments valueForKey:@"auth"] boolValue];
                email.wantsSecure = [[arguments valueForKey:@"security"] boolValue];
                email.validateSSLChain = [[arguments valueForKey:@"SSL"] boolValue];
                email.delegate = self;
                
                NSArray *ports = [[NSMutableArray alloc] initWithArray:[arguments valueForKey:@"ports"] copyItems:YES];
                if (!(!ports || !ports.count)) {
                    email.relayPorts = [[NSArray alloc] initWithArray:ports];
                }
                
                NSString *bodyMessage = [arguments valueForKey:@"body"];
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
