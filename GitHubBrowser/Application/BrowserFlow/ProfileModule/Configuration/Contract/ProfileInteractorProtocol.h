//
//  ProfileInteractorProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UserProfileRecord;
@class RepositoryRecord;

@protocol ProfileInteractorDelegate <NSObject>

- (void)userNotAuthorized;

- (void)userProfileReveived:(UserProfileRecord *)userProfile;
- (void)userRepositoriesReceived:(NSArray<RepositoryRecord *> *)repositories;

@end

@protocol ProfileInteractorProtocol <NSObject>
@property (nonatomic, weak) id<ProfileInteractorDelegate> output;

- (void)fetchData;

@end
