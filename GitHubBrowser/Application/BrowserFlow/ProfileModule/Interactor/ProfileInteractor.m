//
//  ProfileInteractor.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfileInteractor.h"

#import "AsyncOperation.h"

typedef enum : NSUInteger {
    ProfileInteractorStateNotPrepared,
    ProfileInteractorStateAuthorized,
    ProfileInteractorStateUnauthorized,
} ProfileInteractorState;


@interface ProfileInteractor ()

@property (nonatomic) AsyncOperation *avatarFetchingOperation;

@property (nonatomic) ProfileInteractorState state;

@end


@implementation ProfileInteractor

@synthesize output;

- (void)prepare {
    
    if (_state != ProfileInteractorStateNotPrepared) {
        return;
    }
    
    // Detect if we are authorized or not.
    NSString *token = [self.tokenStorage fetchTokenFromSecureStorage];
    
    if (!token) {
        [self gh_processWithNotAuthorizedState];
        return;
    }
    
    // Provide token to networking service.
    [self.profileNetworking prepareWithUserToken:token];
    
    //
    [self gh_processWithAuthorizedState];
    
    // Fetch initial data.
    [self fetchData];
}

- (void)fetchData {
    // Try to fetch user profile.
    [self gh_fetchUserProfile];
    
    // Try to fetch user repositories.
    [self gh_fetchUserRepositories];
}

- (void)performSignOut {
    [self gh_safelyMoveToUnauthorizedState];
}

- (void)gh_safelyMoveToUnauthorizedState {
    // Remove token from storage.
    [self.tokenStorage removeTokenFromSecureStorage];
    
    // Notify with sign-out finished.
    [self gh_processWithNotAuthorizedState];
    
    // Cancel avatar loading.
    [_avatarFetchingOperation cancelOperation];
}

- (void)gh_fetchUserProfile {
    
    __weak typeof(self) _self = self;
    
    [self.profileNetworking fetchUserProfileWithResponse:^(UserProfileRecord * _Nullable userProfile) {
        if (!userProfile) {
            [_self gh_safelyMoveToUnauthorizedState];
            return;
        }
        
        // Notify presenter layer with user profile.
        [_self.output userProfileReveived:userProfile];
        
        // Fetch user avatar.
        [_self gh_fetchUserAvatar:userProfile.avatarUrl];
    }];
    
}

- (void)gh_fetchUserRepositories {
    
    __weak typeof(self) _self = self;
    [self.profileNetworking fetchUserRepositories:^(NSArray<RepositoryRecord *> * _Nullable repositories) {
        
        if (!repositories) {
            [_self gh_safelyMoveToUnauthorizedState];
            return;
        }
        
        [_self.output userRepositoriesReceived:repositories];
    }];
}

- (void)gh_fetchUserAvatar:(NSString *)link {
    
    [_avatarFetchingOperation cancelOperation];

    __weak typeof(self) _self = self;
    _avatarFetchingOperation = [self.mediaProvider fetchImageMediaFromLink:link
                                                                  response:^(UIImage * _Nullable image) {
                                                                      if (image) {
                                                                          [_self.output userAvatarReceived:image];
                                                                      }
                                                                      
                                                                      _avatarFetchingOperation = nil;
                                                                  }];
    
}

- (void)gh_processWithNotAuthorizedState {
    
    // Set unauthorized state.
    _state = ProfileInteractorStateUnauthorized;
    
    // Notify with event.
    [self.output userNotAuthorized];
}


- (void)gh_processWithAuthorizedState {
    
    // Set unauthorized state.
    _state = ProfileInteractorStateAuthorized;
    
    // Notify with event.
    [self.output userAuthorized];
}

@end
