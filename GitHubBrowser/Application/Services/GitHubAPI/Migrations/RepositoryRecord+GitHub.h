//
//  RepositoryRecord+GitHub.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "RepositoryRecord.h"
#import "GHRepositoryEntity.h"

@interface RepositoryRecord (GitHub)

+ (instancetype)repositoryRecordWithGitHubRepository:(GHRepositoryEntity *)repositoryEntity;

@end
