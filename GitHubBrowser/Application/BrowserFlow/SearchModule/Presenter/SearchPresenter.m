//
//  SearchPresenter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "SearchPresenter.h"

@implementation SearchPresenter

@synthesize output;
@synthesize view;
@synthesize interactor;
@synthesize router;

#pragma mark - View Layer Feedback -

- (void)viewReadyForInteractions {
    [self.interactor fetchSearchHistory];
}

- (void)userWantsToSearchWithText:(NSString *)text {
    [self.interactor searchRepositoriesWithText:text];
}

- (void)userWantsToCancelSearch {
    [self.interactor cancelSearch];
}

#pragma mark - Interactor Layer Feedback -

- (void)searchHistoryFetched:(NSArray<NSString *> *)historyList {
    
    if (!historyList.count) {
        [self.view showEmpty];
        return;
    }
    
    [self.view showSearchHistory:historyList];
}

- (void)searchResultsReceived:(NSArray<RepositoryRecord *> *)repositories {
    
    if (!repositories.count) {
        [self.view showNotFound];
        return;
    }
    
    [self.view showSearchResults:repositories];
}

@end
