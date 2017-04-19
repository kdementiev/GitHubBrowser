//
//  LocalStorageService.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SearchHistoryLocalStorageProtocol.h"

@interface LocalStorageService : NSObject<SearchHistoryLocalStorageProtocol>

@end
