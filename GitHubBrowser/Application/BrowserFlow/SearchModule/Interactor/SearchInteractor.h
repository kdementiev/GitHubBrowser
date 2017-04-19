//
//  SearchInteractor.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SearchInteractorProtocol.h"

// Services that used by interactor.
#import "SearchNetworkingProtocol.h"
#import "SearchHistoryLocalStorageProtocol.h"

@interface SearchInteractor : NSObject<SearchInteractorProtocol>

@property (nonatomic) id<SearchNetworkingProtocol> searchNetworking;
@property (nonatomic) id<SearchHistoryLocalStorageProtocol> historyLocalStorage;

@end
