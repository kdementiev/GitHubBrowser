//
//  GHUserProfileTestCase.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHTestCase.h"
#import "GitHubUserProfileService.h"

@interface GHUserProfileTestCase : GHTestCase

@property (nonatomic) GitHubUserProfileService *userProfileService;

@end
