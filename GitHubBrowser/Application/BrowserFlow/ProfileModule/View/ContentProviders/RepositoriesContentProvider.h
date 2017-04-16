//
//  RepositoriesContentProvider.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RepositoryRecord;

@interface RepositoriesContentProvider : NSObject<UITableViewDataSource>

+ (id<UITableViewDataSource>)contentProviderWithRepositories:(NSArray<RepositoryRecord *> *)repositories;

@end
