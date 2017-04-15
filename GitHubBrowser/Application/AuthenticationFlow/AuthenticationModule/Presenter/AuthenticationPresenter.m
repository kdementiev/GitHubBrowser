//
//  AuthenticationPresenter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AuthenticationPresenter.h"

@implementation AuthenticationPresenter

@synthesize output;
@synthesize view;
@synthesize interactor;
@synthesize router;

#pragma mark - View Layer Feedback -

- (void)userWantsToCancel {
    [self.router navigateBack];
}

#pragma mark - Interactor Layer Feedback -


#pragma mark - Outside Module Feedback -

@end
