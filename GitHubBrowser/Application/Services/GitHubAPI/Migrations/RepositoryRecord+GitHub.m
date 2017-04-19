//
//  RepositoryRecord+GitHub.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "RepositoryRecord+GitHub.h"

@implementation RepositoryRecord (GitHub)

+ (instancetype)repositoryRecordWithGitHubRepository:(GHRepositoryEntity *)repositoryEntity {
    RepositoryRecord *repository = [RepositoryRecord new];
    
    repository.ownerName = repositoryEntity.owner.login;
    
    repository.name = repositoryEntity.name;
    repository.desc = repositoryEntity.desc;
    
    repository.language = repositoryEntity.language;
    repository.starsCount = repositoryEntity.stargazersCount;
    
    return repository;
}

@end
