//
//  ProfileInteractor.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfileInteractor.h"

@implementation ProfileInteractor

@synthesize output;

- (void)fetchData {
    
    [self.output userNotAuthorized];
}

@end
