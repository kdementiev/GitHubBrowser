//
//  SearchInteractorProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol SearchInteractorDelegate <NSObject>
@end

@protocol SearchInteractorProtocol <NSObject>
@property (nonatomic, weak) id<SearchInteractorDelegate> output;
@end
