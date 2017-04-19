//
//  AuthenticationInteractorProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthenticationInteractorDelegate <NSObject>

- (void)twoFactorAuthenticationRequired;

- (void)invalidUserName;
- (void)invalidUserPassword;
- (void)invalidTwoFactorCode;

- (void)authenticationSuccessfullyPassed;
- (void)authenticationFailedWithBadCredentials;

@end

@protocol AuthenticationInteractorProtocol <NSObject>
@property (nonatomic, weak) id<AuthenticationInteractorDelegate> output;

- (void)loginWithUserName:(NSString *)userName password:(NSString *)password;
- (void)loginWithTwoFactorCode:(NSString *)code;

@end
