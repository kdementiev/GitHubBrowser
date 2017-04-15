//
//  ProfilePresenter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfilePresenter.h"

@implementation ProfilePresenter

@synthesize output;
@synthesize view;
@synthesize interactor;
@synthesize router;

#pragma mark - View Layer Feedback -

- (void)onUserWantsToSignIn {
    [self.router navigateToAuthorizationScreen];
}

- (void)onUserWantsLatestData {
    [self.interactor fetchData];
}

#pragma mark - Interactor Layer Feedback -

- (void)userNotAuthorized {
    
}

- (void)userProfileReveived:(UserProfileRecord *)userProfile {
    
}

- (void)userRepositoriesReceived:(NSArray<RepositoryRecord *> *)repositories {
    
}

@end
