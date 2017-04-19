//
//  SearchRouter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "SearchRouter.h"

#import <UIKit/UIKit.h>


@interface SearchRouter ()

// Use UIViewController to perform routing using segues or in another way
@property (nonatomic, weak) UIViewController *viewController;

@end


@implementation SearchRouter

- (void)prepareWithViewController:(id)viewController {
    NSAssert([viewController isKindOfClass:[UIViewController class]], @"Invalid object instance passed. UIViewController needed.");
    _viewController = viewController;
}

@end
