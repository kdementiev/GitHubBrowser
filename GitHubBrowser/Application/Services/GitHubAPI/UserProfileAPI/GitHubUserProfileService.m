//
//  GitHubUserProfileService.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GitHubUserProfileService.h"

#import "GitHubAPINetworking.h"
#import "GHUserEntity.h"

// Routes
NSString * const GitHubAPIUserProfileRoute = @"user";
NSString * const GitHubAPIUserRepositoriesRoute = @"user/repos/";

// Query params
NSString * const GitHubAPIAccessTokenQueryParamName = @"access_token";


@interface GitHubUserProfileService ()

@property (nonatomic) NSMutableDictionary *requiredFieldsDict;

@end


@implementation GitHubUserProfileService

- (NSMutableDictionary *)requiredFieldsDict {
    
    if (!_requiredFieldsDict) {
        _requiredFieldsDict = [NSMutableDictionary dictionary];
    }
    
    return _requiredFieldsDict;
}

- (void)prepareWithUserToken:(nonnull NSString *)token {
    
    NSAssert(token != nil, @"You must provide token.");

    // Save Auth2 token as required.
    [self.requiredFieldsDict setValue:token forKey:GitHubAPIAccessTokenQueryParamName];
}

- (void)fetchUserProfileWithResponse:(nonnull UserProfileNetworkingUserProfileResponseCallback)callback {
    
    NSAssert(callback != nil, @"You must provide response callback.");
    
    [gitHubNetworking performGET:GitHubAPIUserProfileRoute
                          params:self.requiredFieldsDict
                           class:[GHUserEntity class]
                        response:^(NSError *error, id responseObject, NSDictionary *headers) {
                            
                            UserProfileRecord *userProfile;
                            
                            if (responseObject) {
                                GHUserEntity *userEntity = responseObject;
                                
                                
                            }
                            
                            callback(userProfile);
                        }];
    
}

- (void)fetchUserRepositories:(nonnull UserProfileNetworkingRepositoriesResponseCallback)callback {
    
    NSAssert(callback != nil, @"You must provide response callback.");
    
}

//- (NSString *)gh_routeWithToken:(NSString *)route {
////    return [NSString stringWithFormat:@"?authToken=%@", GitHubAPIUserProfileRoute];
//}

@end
