//
//  GHUserProfileTestCase.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHUserProfileTestCase.h"

@implementation GHUserProfileTestCase

- (void)setUp {
    [super setUp];
    
    self.userProfileService = [GitHubUserProfileService new];
}

@end
