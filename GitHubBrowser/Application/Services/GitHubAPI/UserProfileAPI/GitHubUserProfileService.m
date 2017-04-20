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
#import "GHRepositoryEntity.h"

#import "UserProfileRecord+GitHub.h"
#import "RepositoryRecord+GitHub.h"

#import "NetworkingAsyncOperationAdapter.h"

// Routes
NSString * const GitHubAPIUserProfileRoute = @"user";
NSString * const GitHubAPIUserRepositoriesRoute = @"user/repos";

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

- (AsyncOperation *)fetchUserProfileWithResponse:(nonnull UserProfileNetworkingUserProfileResponseCallback)callback {
    
    NSAssert(callback != nil, @"You must provide response callback.");
    
    NSURLSessionDataTask *dataTask;
    dataTask = [gitHubNetworking performGET:GitHubAPIUserProfileRoute
                                     params:self.requiredFieldsDict
                                      class:[GHUserEntity class]
                                   response:^(NSError *error, id responseObject, NSDictionary *headers) {
                                       
                                       UserProfileRecord *userProfile;
                                       
                                       if (responseObject) {
                                           GHUserEntity *userEntity = responseObject;
                                           userProfile = [UserProfileRecord userProfileRecordWithGitHubUser:userEntity];
                                       }
                                       
                                       callback(userProfile);
                                   }];
    
    return [NetworkingAsyncOperationAdapter asyncOperationWithSessionDtaTask:dataTask];
}

- (AsyncOperation *)fetchUserRepositories:(nonnull UserProfileNetworkingRepositoriesResponseCallback)callback {
    
    NSAssert(callback != nil, @"You must provide response callback.");
    
    NSURLSessionDataTask *dataTask;
    dataTask = [gitHubNetworking performGET:GitHubAPIUserRepositoriesRoute
                                     params:self.requiredFieldsDict
                                      class:[GHRepositoryEntity class]
                                   response:^(NSError *error, id responseObject, NSDictionary *headers) {
                                       
                                       NSMutableArray<RepositoryRecord *> *repositories;
                                       
                                       if (responseObject) {
                                           repositories = [NSMutableArray array];
                                           
                                           NSArray<GHRepositoryEntity *> *gitHubRepositories = responseObject;
                                           [gitHubRepositories enumerateObjectsUsingBlock:^(GHRepositoryEntity * _Nonnull repository, NSUInteger idx, BOOL * _Nonnull stop) {
                                               RepositoryRecord *repositoryRecord = [RepositoryRecord repositoryRecordWithGitHubRepository:repository];
                                               [repositories addObject:repositoryRecord];
                                           }];
                                       }
                                       
                                       callback([repositories copy]);
                                   }];
    
    return [NetworkingAsyncOperationAdapter asyncOperationWithSessionDtaTask:dataTask];
}

@end













