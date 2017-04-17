//
//  GitHubAPIAuthentication.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GHAuthEntity.h"

typedef void(^GitHubAPIAuthenticationResponseCallback)(BOOL success);
typedef void(^GitHubAPIAuthenticationCredentialsResponseCallback)(GHAuthEntity *authEntity, NSError *error);


@interface GitHubAPIAuthentication : NSObject

+ (void)authenticateWithName:(NSString *)name password:(NSString *)password otp:(NSString *)otp response:(GitHubAPIAuthenticationCredentialsResponseCallback)callback;

+ (void)deleteAuthorizationWithId:(NSInteger)identifier response:(GitHubAPIAuthenticationResponseCallback)response;

@end
