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
@class UIImage;

@protocol ProfileInteractorDelegate <NSObject>

- (void)userAuthorized;
- (void)userNotAuthorized;

- (void)userAvatarReceived:(UIImage *)image;
- (void)userProfileReveived:(UserProfileRecord *)userProfile;
- (void)userRepositoriesReceived:(NSArray<RepositoryRecord *> *)repositories;

@end

@protocol ProfileInteractorProtocol <NSObject>
@property (nonatomic, weak) id<ProfileInteractorDelegate> output;

- (void)prepare;
- (void)fetchData;

- (void)performSignOut;

@end
