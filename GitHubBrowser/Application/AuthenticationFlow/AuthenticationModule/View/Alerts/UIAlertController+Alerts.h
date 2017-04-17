//
//  UIAlertController+Alerts.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UIAlertControllerTwoFactorCodeCallback)(NSString *code);

@interface UIAlertController (Alerts)

+ (instancetype)twoFactorAlertWithDoneAction:(UIAlertControllerTwoFactorCodeCallback)callback;

+ (instancetype)errorAlertWithMessage:(NSString *)message;

@end
