//
//  GitHubAPIAuthentication.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHAuthEntity.h"

typedef enum : NSUInteger {
    GitHubAPIAuthenticationTwoFactorNone,
    GitHubAPIAuthenticationTwoFactorSMS,
    GitHubAPIAuthenticationTwoFactorApplication,
} GitHubAPIAuthenticationTwoFactorType;


typedef void(^GitHubAPIAuthenticationResponseCallback)(BOOL success);
typedef void(^GitHubAPIAuthenticationCredentialsResponseCallback)(GHAuthEntity *authEntity, GitHubAPIAuthenticationTwoFactorType type);


@interface GitHubAPIAuthentication : NSObject

+ (void)authenticateWithName:(NSString *)name password:(NSString *)password otp:(NSString *)otp response:(GitHubAPIAuthenticationCredentialsResponseCallback)callback;

+ (void)deleteAuthorizationWithId:(NSInteger)identifier response:(GitHubAPIAuthenticationResponseCallback)response;

@end
