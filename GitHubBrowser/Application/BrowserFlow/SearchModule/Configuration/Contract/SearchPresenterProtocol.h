//
//  SearchPresenterProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "SearchViewProtocol.h"
#import "SearchInteractorProtocol.h"
#import "SearchRouterProtocol.h"
#import "SearchModuleProtocol.h"


@protocol SearchPresenterProtocol <SearchViewDelegate, SearchInteractorDelegate, SearchModuleProtocol>

// Offers interfce to store information or events outside this module.
@property (nonatomic, weak) id<SearchModuleDelegate> output;

// View owns presenter because of UIKit, accourding to this we use 'weak'.
@property (nonatomic, weak) id<SearchViewProtocol> view;

// Contains bussiness logic.
@property (nonatomic) id<SearchInteractorProtocol> interactor;

// Allows to perform routing between modules (Screens)
@property (nonatomic) id<SearchRouterProtocol> router;

@end
