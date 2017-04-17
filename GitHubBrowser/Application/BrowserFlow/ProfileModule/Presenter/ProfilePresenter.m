//
//  ProfilePresenter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfilePresenter.h"

#import "AuthenticationModuleProtocol.h"

@implementation ProfilePresenter

@synthesize output;
@synthesize view;
@synthesize interactor;
@synthesize router;

#pragma mark - Authentication Module Feedback -

- (void)userSuccessfullySignedIn {
    [self.interactor prepare];
}

#pragma mark - View Layer Feedback -

- (void)viewReadyForInteractions {
    [self.interactor prepare];
}

- (void)userWantsToSignOut {
    [self.interactor performSignOut];
}

- (void)userWantsToSignIn {
    [self.router navigateToAuthorizationScreenWithDelegate:self];
}

- (void)userWantsLatestData {
    [self.interactor fetchData];
}

#pragma mark - Interactor Layer Feedback -

- (void)userAuthorized {
    [self.view showNoContentState];
}

- (void)userNotAuthorized {
    [self.view showUnauthorizedState];
}

- (void)userAvatarReceived:(UIImage *)image {
    [self.view showUserAvatar:image];
}

- (void)userProfileReveived:(UserProfileRecord *)userProfile {
    [self.view showUserProfile:userProfile];
}

- (void)userRepositoriesReceived:(NSArray<RepositoryRecord *> *)repositories {
    
    // Presenter decides what state we need to be shown by view layer.
    
    if (!repositories.count) {
        [self.view showNoContentState];
        return;
    }
    
    [self.view showRepositories:repositories];
}

@end
