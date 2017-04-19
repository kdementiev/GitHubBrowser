//
//  SearchInteractorProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepositoryRecord;

@protocol SearchInteractorDelegate <NSObject>

- (void)searchHistoryFetched:(NSArray<NSString *> *)historyList;
- (void)searchResultsReceived:(NSArray<RepositoryRecord *> *)repositories;

@end

@protocol SearchInteractorProtocol <NSObject>
@property (nonatomic, weak) id<SearchInteractorDelegate> output;

- (void)fetchSearchHistory;

- (void)searchRepositoriesWithText:(NSString *)text;
- (void)cancelSearch;

@end
