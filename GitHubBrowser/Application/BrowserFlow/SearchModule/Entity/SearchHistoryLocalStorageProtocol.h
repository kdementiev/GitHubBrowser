//
//  SearchHistoryLocalStorageProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AsyncOperation.h"

typedef void(^SearchHistoryLocalStorageResponseCallback)(NSArray<NSString *> * _Nonnull queries);

@protocol SearchHistoryLocalStorageProtocol <NSObject>

- (void)saveSearchQuery:(nonnull NSString *)query;
- (nonnull AsyncOperation *)fetchSearchQueriesWithResponse:(nonnull SearchHistoryLocalStorageResponseCallback)callback;

@end
