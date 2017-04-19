//
//  AuthenticationInteractor.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AuthenticationInteractor.h"

@interface AuthenticationInteractor ()
@property (nonatomic) AuthCredentials *authCredentials;
@end

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
    
    // Prepare and save AuthCredentials for authService.
    self.authCredentials = [AuthCredentials authCredentialsWithUser:userName
                                                           password:password
                                                            otpCode:nil];
    
    
    [self gh_loginFlowWithCredentials:_authCredentials];
}

- (void)loginWithTwoFactorCode:(NSString *)code {
    
    // 
    if (![self.credentialsValidator validateOTPCode:code]) {
        [self.output invalidTwoFactorCode];
        return;
    }
    
    NSAssert(_authCredentials != nil, @"No authcredentials instance.");
    
    // Seve received code.
    _authCredentials.otpCode = code;
    
    // Login with updated credentials
    [self gh_loginFlowWithCredentials:_authCredentials];
}

- (void)gh_loginFlowWithCredentials:(AuthCredentials *)credentials {
    
    __weak typeof(self) _self = self;
    
    // Try to login.
    [self.authService loginWithCredentials:credentials
                                  response:^(NSString * _Nullable authToken, AuthenticationServiceResponseError error) {
                                      
                                      if (authToken) {
                                          [_self gh_saveTokenAndNotifyWithSuccess:authToken];
                                          return;
                                      }
                                      
                                      [_self gh_processAuthenticationError:error];
                                  }];
}

- (void)gh_saveTokenAndNotifyWithSuccess:(NSString *)token {
    
    // Put token into secure local storage.
    [self.tokenStorage saveTokenToSecureStorage:token];
    
    // Notify with success.
    [self.output authenticationSuccessfullyPassed];
}

- (void)gh_processAuthenticationError:(AuthenticationServiceResponseError)error {
    
    switch (error) {
        case AuthenticationServiceResponseErrorBadCredentials:
            [self.output authenticationFailedWithBadCredentials];
            break;
            
        case AuthenticationServiceResponseErrorOTPRequired:
            [self.output twoFactorAuthenticationRequired];
            break;
            
        default:
            break;
    }
    
}

@end
