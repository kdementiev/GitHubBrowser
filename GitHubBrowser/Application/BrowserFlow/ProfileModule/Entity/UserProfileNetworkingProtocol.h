//
//  UserProfileNetworkingProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "UserProfileRecord.h"
#import "RepositoryRecord.h"

#import "AsyncOperation.h"

typedef void(^UserProfileNetworkingUserProfileResponseCallback)(UserProfileRecord * _Nullable userProfile);
typedef void(^UserProfileNetworkingRepositoriesResponseCallback)(NSArray<RepositoryRecord *> * _Nullable repositories);

/*!
 *  @disscussion Describe interface that offers communication with remote server.
 *  You must implement this protocol in your Networking Service to provide activity for module. 
 */
@protocol UserProfileNetworkingProtocol <NSObject>

/*!
 *  @disscussion Offers inerface to prepare with token and handle auth state.
 *  @param token User Auth2 token.
 */
- (void)prepareWithUserToken:(nonnull NSString *)token;

/*!
 *  @disscussion Offers interface to get user profile from remote server.
 *  @praram callback Response callback that will be called when data received from server.
 */
- (nonnull AsyncOperation *)fetchUserProfileWithResponse:(nonnull UserProfileNetworkingUserProfileResponseCallback)callback;

/*!
 *  @disscussion Offers interface to get user repositories from remote server.
 *  @praram callback Response callback that will be called when data received from server.
 */
- (nonnull AsyncOperation *)fetchUserRepositories:(nonnull UserProfileNetworkingRepositoriesResponseCallback)callback;

@end
