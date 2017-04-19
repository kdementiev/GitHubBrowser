//
//  RepositoriesDataSource.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//


#import <UIKit/UIKit.h>
//#import "TableViewContentProviderProtocol.h"

@class RepositoryRecord;

@interface RepositoriesDataSource : NSObject<UITableViewDataSource>

+ (id<UITableViewDataSource>)dataSourceWithRepositories:(NSArray<RepositoryRecord *> *)repositories;

@end
