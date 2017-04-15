//
//  AuthenticationPresenterProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AuthenticationViewProtocol.h"
#import "AuthenticationInteractorProtocol.h"
#import "AuthenticationRouterProtocol.h"
#import "AuthenticationModuleProtocol.h"


@protocol AuthenticationPresenterProtocol <AuthenticationViewDelegate, AuthenticationInteractorDelegate, AuthenticationModuleProtocol>

// Offers interfce to store information or events outside this module.
@property (nonatomic, weak) id<AuthenticationModuleDelegate> output;

// View owns presenter because of UIKit, accourding to this we use 'weak'.
@property (nonatomic, weak) id<AuthenticationViewProtocol> view;

// Contains bussiness logic.
@property (nonatomic) id<AuthenticationInteractorProtocol> interactor;

// Allows to perform routing between modules (Screens)
@property (nonatomic) id<AuthenticationRouterProtocol> router;

@end
