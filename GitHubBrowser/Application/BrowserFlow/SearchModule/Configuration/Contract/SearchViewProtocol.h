//
//  SearchViewProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RepositoryRecord;

// Events from view
@protocol SearchViewDelegate <NSObject>

- (void)viewReadyForInteractions;

- (void)userWantsToSearchWithText:(NSString *)text;
- (void)userWantsToCancelSearch;

@end

// Provides ability to controll view
@protocol SearchViewProtocol <NSObject>

// Strong because we need to own output to support our structure.
@property (nonatomic, strong) id<SearchViewDelegate> output;

- (void)showEmpty;
- (void)showNotFound;

- (void)showSearchHistory:(NSArray<NSString *> *)historyList;
- (void)showSearchResults:(NSArray<RepositoryRecord *> *)repositories;

@end
