//
//  UIAlertController+ProfileAlerts.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UIAlertController+ProfileAlerts.h"

@implementation UIAlertController (ProfileAlerts)

+ (instancetype)signOutAlertWithResponse:(UIAlertControllerSignOutCallback)callback {
    
    NSString *title = NSLocalizedString(@"SIGN-OUT", nil);
    NSString *message = NSLocalizedString(@"Are you sure you want to Sign-Out?", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *signOutAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"YES", nil)
                                                            style:UIAlertActionStyleDestructive
                                                          handler:^(UIAlertAction * _Nonnull action) {
                                                              callback();
                                                          }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"Cancel", nil)
                                                            style:UIAlertActionStyleCancel
                                                          handler:nil];
    
    [alertController addAction:signOutAction];
    [alertController addAction:cancelAction];
    
    return alertController;
}

@end
