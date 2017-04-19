//
//  UserProfileRecord+GitHub.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UserProfileRecord.h"
#import "GHUserEntity.h"


@interface UserProfileRecord (GitHub)

+ (instancetype)userProfileRecordWithGitHubUser:(GHUserEntity *)userEntity;

@end
