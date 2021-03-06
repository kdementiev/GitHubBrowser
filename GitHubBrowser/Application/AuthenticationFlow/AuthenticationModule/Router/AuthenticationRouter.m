//
//  AuthenticationRouter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AuthenticationRouter.h"

#import <UIKit/UIKit.h>


NSString * const AuthenticationRouterCreateAccountLink = @"https://github.com/join?source=login";


@interface AuthenticationRouter ()

// Use UIViewController to perform routing using segues or in another way
@property (nonatomic, weak) UIViewController *viewController;

@end


@implementation AuthenticationRouter

- (void)prepareWithViewController:(id)viewController {
    NSAssert([viewController isKindOfClass:[UIViewController class]], @"Invalid object instance passed. UIViewController needed.");
    _viewController = viewController;
}

- (void)navigateToCreateAccount {
    NSURL *createAccountURL = [NSURL URLWithString:AuthenticationRouterCreateAccountLink];
    [[UIApplication sharedApplication] openURL:createAccountURL options:@{} completionHandler:nil];
}

- (void)navigateBack {
    [self.viewController.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
