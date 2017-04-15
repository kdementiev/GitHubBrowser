//
//  ProfilePresenterProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ProfileViewProtocol.h"
#import "ProfileInteractorProtocol.h"
#import "ProfileRouterProtocol.h"
#import "ProfileModuleProtocol.h"


@protocol ProfilePresenterProtocol <ProfileViewDelegate, ProfileInteractorDelegate, ProfileModuleProtocol>

// Offers interfce to store information or events outside this module.
@property (nonatomic, weak) id<ProfileModuleDelegate> output;

// View owns presenter because of UIKit, accourding to this we use 'weak'.
@property (nonatomic, weak) id<ProfileViewProtocol> view;

// Contains bussiness logic.
@property (nonatomic) id<ProfileInteractorProtocol> interactor;

// Allows to perform routing between modules (Screens)
@property (nonatomic) id<ProfileRouterProtocol> router;

@end
