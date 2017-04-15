//
//  ProfileRouter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfileRouter.h"

#import <UIKit/UIKit.h>
#import <EasySegues/UIViewController+EasySegues.h>

// Module configurators
#import "AuthenticationModuleConfigurator.h"


@interface ProfileRouter ()

// Use UIViewController to perform routing using segues or in another way
@property (nonatomic, weak) UIViewController *viewController;

@end


@implementation ProfileRouter

- (void)prepareWithViewController:(id)viewController {
    NSAssert([viewController isKindOfClass:[UIViewController class]], @"Invalid object instance passed. UIViewController needed.");
    _viewController = viewController;
}

- (void)navigateToAuthorizationScreen {
    
    [_viewController performSegueWithIdentifier:@"AuthenticationFlowSegue"
                                prepareCallback:^(UIViewController *target) {
                                    
                                    // We know that this segue involve UINavigationController.
                                    UINavigationController *navigationController = (UINavigationController *)target;
                                    
                                    // We know that our view placed as topViewController, just get it.
                                    id<AuthenticationViewProtocol> view = (id<AuthenticationViewProtocol>)navigationController.topViewController;
                                    
                                    // Prepare module with view.
                                    [AuthenticationModuleConfigurator configureteModuleWithView:view delegate:nil];
                                }];
    
}

@end
