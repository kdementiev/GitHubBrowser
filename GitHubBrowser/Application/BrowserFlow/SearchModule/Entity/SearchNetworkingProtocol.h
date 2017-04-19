//
//  SearchNetworkingProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AsyncOperation.h"

@class RepositoryRecord;

typedef void(^SearchNetworkingSearchResultsCallback)(NSArray<RepositoryRecord *> * _Nullable repositories);

/*!
 *
 */
@protocol SearchNetworkingProtocol <NSObject>

- (nonnull AsyncOperation *)searchRepositoriesWithText:(nonnull NSString *)text response:(nonnull SearchNetworkingSearchResultsCallback)callback;

@end
