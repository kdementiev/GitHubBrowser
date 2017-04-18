//
//  AuthenticationViewController.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AuthenticationViewController.h"

#import "UITextField+ErrorState.h"
#import "UIAlertController+AuthenticationAlerts.h"

@interface AuthenticationViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *loginTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (weak, nonatomic) UITextField *currentTextField;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation AuthenticationViewController

@synthesize output;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self gh_subscribeForKeyboardNotifications];
}

- (void)gh_subscribeForKeyboardNotifications {
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gh_keyboardDidShow:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(gh_keyboardDidShow:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - Keyboard Notifications -

- (void)gh_keyboardDidShow:(NSNotification*)notification {
    
    NSDictionary* info = [notification userInfo];
    CGRect keyboardRect = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardRect.size.height, 0.0);
    _scrollView.contentInset = contentInsets;
    
    CGRect frame = self.view.frame;
    frame.size.height -= keyboardRect.size.height;
    
    if (!CGRectContainsPoint(frame, _currentTextField.frame.origin) ) {
        [self.scrollView scrollRectToVisible:_currentTextField.frame animated:YES];
    }
}

- (void)gh_keyboardWillHide:(NSNotification*)notification {
    _scrollView.contentInset = UIEdgeInsetsZero;
}

#pragma mark - View Layer Actions -

- (void)showActivityState:(BOOL)show {
    
    self.activityIndicator.hidden = !show;
    if (show) {
        [self.activityIndicator startAnimating];
    }
    
    self.view.userInteractionEnabled = !show;
}

- (void)showInvalidCredentialsMessage {
    [self gh_showErrorAlertWithMessage:NSLocalizedString(@"Invalid credentials. Please try again.", nil)];
}

- (void)showInvalidTwoFactorCodeMessage {
    [self gh_showErrorAlertWithMessage:NSLocalizedString(@"Invalid two-factor code. Please try again.", nil)];
}

- (void)showUserNameError {
    [_loginTextField showError:YES];
}

- (void)showPasswordError {
    [_passwordTextField showError:YES];
}

- (void)showTwoFactorCodeInput {
    
    UIAlertController *alertController = [UIAlertController twoFactorAlertWithDoneAction:^(NSString *code) {
        [self.output userProvidesTwoFactorCode:code];
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - User Input -

- (IBAction)onCancelAction:(id)sender {
    [self.output userWantsToCancel];
}

- (IBAction)onSignInAction:(id)sender {
    [self gh_notifyWithUserWantsToLogin];
}

- (IBAction)onNoAccountAction:(id)sender {
    [self.output userWantsToCreateAccount];
}

- (IBAction)onTapOnViewAction:(id)sender {
    [self gh_dissmissKeyboard];
}

#pragma mark - UITextFieldDelegate -

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    
    // Save current text field.
    _currentTextField = textField;
    
    // Disable error promt.
    [_currentTextField showError:NO];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    if (textField == _loginTextField) {
        [_passwordTextField becomeFirstResponder];
        return YES;
    }
    
    // Dissmiss keyboard before async job
    [self gh_dissmissKeyboard];
    
    // Remove error if exists
    [_currentTextField showError:NO];
    
    // Notify with user login action.
    [self gh_notifyWithUserWantsToLogin];
    
    return YES;
}

#pragma mark - Private -

- (void)gh_notifyWithUserWantsToLogin {
    [self.output userWantsToLoginWithUsername:_loginTextField.text
                                     password:_passwordTextField.text];
}

- (void)gh_dissmissKeyboard {
    [_currentTextField resignFirstResponder];
}

- (void)gh_showErrorAlertWithMessage:(NSString *)message {
    UIAlertController *alertController = [UIAlertController authErrorAlertWithMessage:message];
    [self presentViewController:alertController animated:YES completion:nil];
}


@end
