//
//  GitHubCredentialsValidator.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GitHubCredentialsValidator.h"

NSString * const GitHubCredentialsValidatorUserNameExpression = @"^\\w+-?\\w+(?!-)$";
NSString * const GitHubCredentialsValidatorPasswordExpression = @"(?=.*?[a-z])(?=.*?[0-9]).{8,}";
NSString * const GitHubCredentialsValidatorOTPExpression = @"\\d+";

@implementation GitHubCredentialsValidator

- (BOOL)validateUserName:(NSString *)userName {
    return [self sg_validateString:userName withRegex:GitHubCredentialsValidatorUserNameExpression];
}

- (BOOL)validatePassword:(NSString *)password {
    return [self sg_validateString:password withRegex:GitHubCredentialsValidatorPasswordExpression];
}

- (BOOL)validateOTPCode:(NSString *)otpCode {
    return [self sg_validateString:otpCode withRegex:GitHubCredentialsValidatorOTPExpression];
}

- (BOOL)sg_validateString:(NSString *)string withRegex:(NSString *)regex {
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:string];
}

@end
