//
//  ProfileModuleConfigurator.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfileModuleProtocol.h"

@class UIViewController;
@protocol ProfileViewProtocol;


@interface ProfileModuleContainer : NSObject

@property (nonatomic) UIViewController *moduleViewController;
@property (nonatomic, weak) id<ProfileModuleProtocol> moduleInterface;

@end

/*!
 * @class ProfileModuleConfigurator
 * @discussion Offers interface that helps with module preparation.
 */
@interface ProfileModuleConfigurator : NSObject

/**
 *  @desc Creates and set-up all VIPER components for this module.
 *  @param view Instance that implements ProfileViewProtocol. It must be UIViewController instance.
 *  @param delegate Instance that implements ProfileModuleDelegate protocol. Use Delegate to be up-to-date with events from this module.
 *  @return Module container that allows you to controll another module.
 */
+ (ProfileModuleContainer *)configureteModuleWithView:(id<ProfileViewProtocol>)view delegate:(id<ProfileModuleDelegate>)delegate;

@end
