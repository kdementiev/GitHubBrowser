//
//  UITextField+ErrorState.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UITextField+ErrorState.h"

CGFloat const UITextFieldDefaultCornerRadius = 5;
CGFloat const UITextFieldErrorCornerRadius = 5;

@implementation UITextField (ErrorState)

- (void)showError:(BOOL)show {
    self.layer.cornerRadius = show ? UITextFieldErrorCornerRadius : UITextFieldDefaultCornerRadius;
    self.layer.borderColor = show ? [UIColor redColor].CGColor : [UIColor blackColor].CGColor;
    self.layer.borderWidth = (CGFloat)show;
}

@end
