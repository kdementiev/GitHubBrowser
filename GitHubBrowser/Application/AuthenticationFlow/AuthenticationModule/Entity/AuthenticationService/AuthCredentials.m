//
//  AuthCredentials.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AuthCredentials.h"

@implementation AuthCredentials

+ (instancetype)authCredentialsWithUser:(NSString *)user password:(NSString *)password otpCode:(NSString *)otpCode {
    AuthCredentials *credentials = [AuthCredentials new];
    
    credentials.userName = user;
    credentials.password = password;
    credentials.otpCode = otpCode;
    
    return credentials;
}

@end
