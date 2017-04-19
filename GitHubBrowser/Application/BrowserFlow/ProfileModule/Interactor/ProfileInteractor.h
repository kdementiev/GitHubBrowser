//
//  ProfileInteractor.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfileInteractorProtocol.h"

// Services that used by interactor.
#import "TokenStorageServiceProtocol.h"
#import "MediaContentServiceProtocol.h"
#import "UserProfileNetworkingProtocol.h"

@interface ProfileInteractor : NSObject<ProfileInteractorProtocol>

@property (nonatomic, strong) id<TokenStorageServiceProtocol> tokenStorage;
@property (nonatomic, strong) id<MediaContentServiceProtocol> mediaProvider;
@property (nonatomic, strong) id<UserProfileNetworkingProtocol> profileNetworking;

@end
