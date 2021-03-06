/**
 The MIT License (MIT)
 
 Copyright (c) 2015 Rodolfo Natan Silva Queiroz.
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all
 copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 SOFTWARE.
 **/

#import "BackgroundEmail.h"
#import <CFNetwork/CFNetwork.h>
#import "SKPSMTPMessage.h"
#import "NSData+Base64Additions.h"

@interface BackgroundEmail() <SKPSMTPMessageDelegate>
@end


@implementation BackgroundEmail: CDVPlugin
@synthesize callbackID;
@synthesize email = _email;

-(void)pluginInitialize{
    
}

- (void)sendEmail:(CDVInvokedUrlCommand*)command
{
    
    [self.commandDelegate runInBackground:^{
        _email = [[SKPSMTPMessage alloc] init];
        @try {
            self.callbackID = command.callbackId;
            CDVInvokedUrlCommand *arguments = [command argumentAtIndex:0];
            _email.fromEmail = [arguments valueForKey:@"from"];
            _email.toEmail = [arguments valueForKey:@"to"];
            _email.ccEmail = [arguments valueForKey:@"cc"];
            _email.bccEmail = [arguments valueForKey:@"bcc"];
            _email.subject = [arguments valueForKey:@"subject"];
            _email.login = [arguments valueForKey:@"login"];
            _email.pass = [arguments valueForKey:@"password"];
            _email.relayHost = [arguments valueForKey:@"relayHost"];
            _email.requiresAuth = [[arguments valueForKey:@"auth"] boolValue];
            _email.wantsSecure = [[arguments valueForKey:@"security"] boolValue];
            _email.validateSSLChain = [[arguments valueForKey:@"SSL"] boolValue];
            _email.delegate = self;
            
            NSArray *ports = [[NSMutableArray alloc] initWithArray:[arguments valueForKey:@"ports"] copyItems:YES];
            if (!(!ports || !ports.count)) {
                _email.relayPorts = [[NSArray alloc] initWithArray:ports];
            }
            
            NSString *bodyMessage = [arguments valueForKey:@"body"];
            NSDictionary *actualMessage = [NSDictionary dictionaryWithObjectsAndKeys:@"text/plain", kSKPSMTPPartContentTypeKey, bodyMessage, kSKPSMTPPartMessageKey, @"8bit", kSKPSMTPPartContentTransferEncodingKey, nil];
            _email.parts = [NSArray arrayWithObjects:actualMessage, nil];
            
            [_email send];
        }
        @catch (NSException *exception) {
            CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:[exception description]];
            [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
        }
    }];
}

-(void)messageSent:(SKPSMTPMessage *)message{
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Message sent!"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
}

-(void)messageFailed:(SKPSMTPMessage *)message error:(NSError *)error{
    NSString *errorMsg = [NSString stringWithFormat:@"%@\n%@", [error localizedDescription], [error localizedRecoverySuggestion]];
    CDVPluginResult* pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorMsg];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.callbackID];
}

@end
