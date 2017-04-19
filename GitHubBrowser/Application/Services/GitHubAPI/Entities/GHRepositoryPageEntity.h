//
//  GHRepositoryPageEntity.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHPageEntity.h"
#import "GHRepositoryEntity.h"

@interface GHRepositoryPageEntity : GHPageEntity

@property (nonatomic) NSArray<GHRepositoryEntity> *items;

@end
