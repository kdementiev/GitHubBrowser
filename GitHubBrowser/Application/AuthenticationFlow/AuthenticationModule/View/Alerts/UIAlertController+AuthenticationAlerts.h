//
//  UIAlertController+Alerts.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertControllerTwoFactorCodeCallback)(NSString *code);

@interface UIAlertController (AuthenticationAlerts)

+ (instancetype)twoFactorAlertWithDoneAction:(UIAlertControllerTwoFactorCodeCallback)callback;

+ (instancetype)authErrorAlertWithMessage:(NSString *)message;

@end
