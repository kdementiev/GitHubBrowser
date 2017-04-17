//
//  UIAlertController+Alerts.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UIAlertController+Alerts.h"


@implementation UIAlertController (Alerts)

+ (instancetype)twoFactorAlertWithDoneAction:(UIAlertControllerTwoFactorCodeCallback)callback {
    
    NSString *title = NSLocalizedString(@"Two-Factor Auth", nil);
    NSString *message = NSLocalizedString(@"Obtain code from SMS or Application.", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = NSLocalizedString(@"Code", nil);
        
        textField.borderStyle = UITextBorderStyleRoundedRect;
        textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    }];
    
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"SIGN-IN", nil)
                                                          style:UIAlertActionStyleDefault
                                                        handler:^(UIAlertAction *action) {
                                                            UITextField *codeField = [alertController.textFields firstObject];
                                                            callback(codeField.text);
                                                        }];
    
    [alertController addAction:alertAction];
    
    return alertController;
}

+ (instancetype)errorAlertWithMessage:(NSString *)message {
    
    NSString *title = NSLocalizedString(@"Authentication Error", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title
                                                                             message:message
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:NSLocalizedString(@"OK", nil)
                                                          style:UIAlertActionStyleCancel
                                                        handler:nil];
    
    [alertController addAction:alertAction];
    
    return alertController;
}

@end
