//
//  UIAlertController+ProfileAlerts.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertControllerSignOutCallback)();

@interface UIAlertController (ProfileAlerts)

+ (instancetype)signOutAlertWithResponse:(UIAlertControllerSignOutCallback)callback;

@end
