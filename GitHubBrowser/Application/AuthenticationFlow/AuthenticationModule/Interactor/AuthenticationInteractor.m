//
//  AuthenticationInteractor.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AuthenticationInteractor.h"

@implementation AuthenticationInteractor

@synthesize output;

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password {
    
    // Username may only contain alphanumeric characters or single hyphens, and cannot begin or end with a hyphen
    if (![self.credentialsValidator validateUserName:userName]) {
        [self.output invalidUserName];
        return;
    }
    
    // Password is too short (minimum is 7 characters) and needs at least one number
    if (![self.credentialsValidator validatePassword:password]) {
        [self.output invalidUserPassword];
        return;
    }
}

- (void)loginWithTwoFactorCode:(NSString *)code {
    
    // 
    if (![self.credentialsValidator validateOTPCode:code]) {
        [self.output invalidTwoFactorCode];
        return;
    }
    
}


@end
