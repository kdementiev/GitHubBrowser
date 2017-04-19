//
//  ProfileViewProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class UIImage;
@class UserProfileRecord;
@class RepositoryRecord;


// Events from view
@protocol ProfileViewDelegate <NSObject>

- (void)viewReadyForInteractions;

- (void)userWantsToSignIn;
- (void)userWantsToSignOut;
- (void)userDidAcceptSignOut;

- (void)userWantsLatestData;

@end

// Provides ability to controll view
@protocol ProfileViewProtocol <NSObject>

// Strong because we need to own output to support our structure.
@property (nonatomic, strong) id<ProfileViewDelegate> output;

- (void)showUnauthorizedState;
- (void)showNoContentState;

- (void)showActivity;

- (void)showUserAvatar:(UIImage *)avatar;
- (void)showUserProfile:(UserProfileRecord *)userProfile;
- (void)showRepositories:(NSArray<RepositoryRecord *> *)repositories;

- (void)showSignOutAlert;

@end
