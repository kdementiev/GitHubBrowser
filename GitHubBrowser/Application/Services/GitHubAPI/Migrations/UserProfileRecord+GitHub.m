//
//  UserProfileRecord+GitHub.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UserProfileRecord+GitHub.h"

@implementation UserProfileRecord (GitHub)

+ (instancetype)userProfileRecordWithGitHubUser:(GHUserEntity *)userEntity {
    UserProfileRecord *record = [UserProfileRecord new];
    
    record.userName = userEntity.login;
    record.avatarUrl = userEntity.avatarUrl;
    record.publicRepositoriesCount = userEntity.publicRepos;
    record.followingCount = userEntity.following;
    record.followersCount = userEntity.followers;
    
    return record;
}

@end
