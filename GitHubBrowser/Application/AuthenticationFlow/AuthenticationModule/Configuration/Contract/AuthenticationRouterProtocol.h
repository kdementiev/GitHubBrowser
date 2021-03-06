//
//  AuthenticationRouterProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol AuthenticationRouterProtocol <NSObject>

- (void)prepareWithViewController:(id)viewController;

- (void)navigateToCreateAccount;
- (void)navigateBack;

@end
