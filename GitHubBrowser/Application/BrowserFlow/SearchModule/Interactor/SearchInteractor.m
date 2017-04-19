//
//  SearchInteractor.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "SearchInteractor.h"

@interface SearchInteractor ()

@property (nonatomic) AsyncOperation *historyOperation;
@property (nonatomic) AsyncOperation *searchOperation;

@end


@implementation SearchInteractor

@synthesize output;

#pragma matk - Interactor Controls -

- (void)fetchSearchHistory {
    
    [self gh_cancelAllOperations];
    
    __weak typeof(self) _self = self;
    [self.historyLocalStorage fetchSearchQueriesWithResponse:^(NSArray<NSString *> * _Nonnull queries) {
        [_self.output searchHistoryFetched:queries];
    }];
}

- (void)searchRepositoriesWithText:(NSString *)text {
    
    // Cancel operations
    [self gh_cancelAllOperations];
    
    //
    __weak typeof(self) _self = self;
    _searchOperation = [self.searchNetworking searchRepositoriesWithText:text
                                                                response:^(NSArray<RepositoryRecord *> * _Nullable repositories) {
                                                                    [_self.output searchResultsReceived:repositories];
                                                                }];
    
    // Save query to local storage.
    [self.historyLocalStorage saveSearchQuery:text];
}

- (void)cancelSearch {
    // Cancel all operation if it exists.
    [self gh_cancelAllOperations];
}

#pragma mark - Private Logic -

- (void)gh_cancelAllOperations {
    [_historyOperation cancelOperation];
    [_searchOperation cancelOperation];
}

@end
