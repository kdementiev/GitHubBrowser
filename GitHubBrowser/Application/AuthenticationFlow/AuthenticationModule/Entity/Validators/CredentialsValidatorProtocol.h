//
//  CredentialsValidatorProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CredentialsValidatorProtocol <NSObject>

/*!
 *
 */
- (BOOL)validateUserName:(NSString *)userName;

/*!
 *
 */
- (BOOL)validatePassword:(NSString *)password;

/*!
 *
 */
- (BOOL)validateOTPCode:(NSString *)otpCode;

@end
