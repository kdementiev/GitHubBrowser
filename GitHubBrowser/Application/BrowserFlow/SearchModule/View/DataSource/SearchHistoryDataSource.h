//
//  SearchHistoryDataSource.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "TableViewContentProviderProtocol.h"

@protocol SearchHistoryDataSourceDelegate <NSObject>
- (void)onSearchQuerySelected:(NSString *)query;

@end

@interface SearchHistoryDataSource : NSObject<TableViewContentProviderProtocol>

+ (instancetype)dataSourceWithQueriesList:(NSArray<NSString *> *)queries delegate:(id<SearchHistoryDataSourceDelegate>)delegate;

@end
