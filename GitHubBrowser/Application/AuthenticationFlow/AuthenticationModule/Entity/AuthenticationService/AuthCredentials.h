//
//  AuthCredentials.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AuthCredentials : NSObject

@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *password;

@property (nonatomic) NSString *otpCode;

+ (instancetype)authCredentialsWithUser:(NSString *)user password:(NSString *)password otpCode:(NSString *)otpCode;

@end
