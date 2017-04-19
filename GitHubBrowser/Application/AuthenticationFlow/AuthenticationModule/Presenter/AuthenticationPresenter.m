//
//  AuthenticationPresenter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AuthenticationPresenter.h"

@implementation AuthenticationPresenter

@synthesize output;
@synthesize view;
@synthesize interactor;
@synthesize router;

#pragma mark - View Layer Feedback -

- (void)userWantsToLoginWithUsername:(NSString *)userName password:(NSString *)password {
    
    // Pause user activity.
    [self.view showActivityState:YES];
    
    // Start async login.
    [self.interactor loginWithUserName:userName password:password];
}

- (void)userProvidesTwoFactorCode:(NSString *)code {
    
    // Pause user activity.
    [self.view showActivityState:YES];
    
    // Continue async login.
    [self.interactor loginWithTwoFactorCode:code];
}

- (void)userWantsToCreateAccount {
    [self.router navigateToCreateAccount];
}

- (void)userWantsToCancel {
    [self.router navigateBack];
}

#pragma mark - Interactor Layer Feedback -

- (void)twoFactorAuthenticationRequired {
    [self.view showTwoFactorCodeInput];
}

- (void)invalidUserName {
    [self.view showActivityState:NO];
    [self.view showUserNameError];
}

- (void)invalidUserPassword {
    [self.view showActivityState:NO];
    [self.view showPasswordError];
}

- (void)invalidTwoFactorCode {
    [self.view showActivityState:NO];
    [self.view showTwoFactorCodeInput];
}

- (void)authenticationSuccessfullyPassed {
    
    // Notify with successfully signed-in.
    [self.output userSuccessfullySignedIn];
    
    // Our job done, go back to profile.
    [self.router navigateBack];
}

- (void)authenticationFailedWithBadCredentials {
    [self.view showActivityState:NO];
    [self.view showInvalidCredentialsMessage];
}

#pragma mark - Outside Module Feedback -

@end
