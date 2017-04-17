//
//  AuthenticationServiceProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AuthCredentials.h"

typedef enum : NSUInteger {
    AuthenticationServiceResponseErrorNone,
    AuthenticationServiceResponseErrorBadCredentials,
    AuthenticationServiceResponseErrorOTPRequired
} AuthenticationServiceResponseError;


typedef void(^AuthServiceResponseCallback)(NSString * _Nullable authToken, AuthenticationServiceResponseError error);

/*!
 *  @disscussion Offers interface to interact with remote API to be used in auth way.
 */
@protocol AuthenticationServiceProtocol <NSObject>

/*!
 *  @disscussion Offers simplified way to authenticate user.
 *  @param credentials AuthCredentials instance.
 *  @param callback User provided password.
 */
- (void)loginWithCredentials:(nonnull AuthCredentials *)credentials response:(nonnull AuthServiceResponseCallback)callback;

@end
