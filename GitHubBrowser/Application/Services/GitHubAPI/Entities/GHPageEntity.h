//
//  GHPageEntity.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHRepositoryEntity.h"

@interface GHPageEntity : JSONModel

@property (nonatomic) NSUInteger totalCount;
@property (nonatomic) BOOL incompleteResults;

@property (nonatomic) NSArray *items;

@end
