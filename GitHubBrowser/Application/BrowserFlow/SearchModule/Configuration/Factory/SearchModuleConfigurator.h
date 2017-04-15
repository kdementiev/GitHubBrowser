//
//  SearchModuleConfigurator.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "SearchModuleProtocol.h"

@class UIViewController;
@protocol SearchViewProtocol;


@interface SearchModuleContainer : NSObject

@property (nonatomic) UIViewController *moduleViewController;
@property (nonatomic, weak) id<SearchModuleProtocol> moduleInterface;

@end

/*!
 * @class SearchModuleConfigurator
 * @discussion Offers interface that helps with module preparation.
 */
@interface SearchModuleConfigurator : NSObject

/**
 *  @desc Creates and set-up all VIPER components for this module.
 *  @param view Instance that implements SearchViewProtocol. It must be UIViewController instance.
 *  @param delegate Instance that implements SearchModuleDelegate protocol. Use Delegate to be up-to-date with events from this module.
 *  @return Module container that allows you to controll another module.
 */
+ (SearchModuleContainer *)configureteModuleWithView:(id<SearchViewProtocol>)view delegate:(id<SearchModuleDelegate>)delegate;

@end
