//
//  ProfileRouterProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AuthenticationModuleDelegate;

@protocol ProfileRouterProtocol <NSObject>

- (void)prepareWithViewController:(id)viewController;

- (void)navigateToAuthorizationScreenWithDelegate:(id<AuthenticationModuleDelegate>)delegate;

@end
