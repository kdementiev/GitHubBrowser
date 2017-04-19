//
//  RepositoriesDataSource.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//


#import "TableViewContentProviderProtocol.h"

@class RepositoryRecord;

extern NSInteger RepositoryCellEstimatedHeight;

@interface RepositoriesDataSource : NSObject<TableViewContentProviderProtocol>

+ (instancetype)dataSourceWithRepositories:(NSArray<RepositoryRecord *> *)repositories;

@end
