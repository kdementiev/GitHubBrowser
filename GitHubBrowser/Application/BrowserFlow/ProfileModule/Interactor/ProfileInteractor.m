//
//  ProfileInteractor.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfileInteractor.h"

@interface ProfileInteractor ()

@property (nonatomic) BFCancellationTokenSource *avatarCancelationToken;

@end


@implementation ProfileInteractor

@synthesize output;

- (void)prepare {
    
    // Detect if we are authorized or not.
    NSString *token = [self.tokenStorage fetchTokenFromSecureStorage];
    
    if (!token) {
        [self.output userNotAuthorized];
        return;
    }
    
    // Provide token to networking service.
    __weak typeof(self) _self = self;
    [self.profileNetworking prepareWithUserToken:token unauthorized:^{
        [_self.output userNotAuthorized];
    }];
    
    //
    [self.output userAuthorized];
    
    // Fetch initial data.
    [self fetchData];
}

- (void)fetchData {
    
    [self gh_fetchUserProfile];
    [self gh_fetchUserRepositories];
}

- (void)performSignOut {
    // Remove token from storage.
    [self.tokenStorage removeTokenFromSecureStorage];
    
    // Notify with sign-out finished.
    [self.output userNotAuthorized];
}

- (void)gh_fetchUserProfile {
    
    __weak typeof(self) _self = self;
    
    [self.profileNetworking fetchUserProfileWithResponse:^(UserProfileRecord * _Nullable userProfile) {
        if (userProfile) {
            
            // Notify presenter layer with user profile.
            [_self.output userProfileReveived:userProfile];
            
            // Fetch user avatar.
            [_self gh_fetchUserAvatar:userProfile.avatarUrl];
        }
    }];
    
}

- (void)gh_fetchUserRepositories {
    
    __weak typeof(self) _self = self;
    [self.profileNetworking fetchUserRepositories:^(NSArray<RepositoryRecord *> * _Nullable repositories) {
        [_self.output userRepositoriesReceived:repositories];
    }];
}

- (void)gh_fetchUserAvatar:(NSString *)link {
    
    if (_avatarCancelationToken) {
        [_avatarCancelationToken cancel];
    }
    
    self.avatarCancelationToken = [BFCancellationTokenSource cancellationTokenSource];
    
    BFTask<UIImage *> *imageTask = [self.mediaProvider fetchImageMediaFromLink:link];
    [imageTask continueWithBlock:^id _Nullable(BFTask<UIImage *> * _Nonnull t) {
        
        if (t.result) {
            [self.output userAvatarReceived:t.result];
        }
        
        self.avatarCancelationToken = nil;
        
        return nil;
        
        
    } cancellationToken:_avatarCancelationToken.token];
}

@end
