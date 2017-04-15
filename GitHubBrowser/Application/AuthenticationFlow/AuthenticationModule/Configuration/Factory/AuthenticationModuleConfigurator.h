//
//  AuthenticationModuleConfigurator.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AuthenticationModuleProtocol.h"

@class UIViewController;
@protocol AuthenticationViewProtocol;


@interface AuthenticationModuleContainer : NSObject

@property (nonatomic) UIViewController *moduleViewController;
@property (nonatomic, weak) id<AuthenticationModuleProtocol> moduleInterface;

@end

/*!
 * @class AuthenticationModuleConfigurator
 * @discussion Offers interface that helps with module preparation.
 */
@interface AuthenticationModuleConfigurator : NSObject

/**
 *  @desc Creates and set-up all VIPER components for this module.
 *  @param view Instance that implements AuthenticationViewProtocol. It must be UIViewController instance.
 *  @param delegate Instance that implements AuthenticationModuleDelegate protocol. Use Delegate to be up-to-date with events from this module.
 *  @return Module container that allows you to controll another module.
 */
+ (AuthenticationModuleContainer *)configureteModuleWithView:(id<AuthenticationViewProtocol>)view delegate:(id<AuthenticationModuleDelegate>)delegate;

@end
