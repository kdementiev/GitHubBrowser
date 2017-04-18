//
//  ProfileViewController.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ProfileViewController.h"

// Custom views
#import "UserProfileHeaderView.h"

// Content providers
#import "RepositoriesContentProvider.h"
#import "UnauthorizedContentProvider.h"
#import "NoDataContentProvider.h"

#import "UserProfileRecord.h"

// Alerts
#import "UIAlertController+ProfileAlerts.h"

/*!
 *
 */
@interface ProfileViewController () <UnauthorizedContentProviderDelegate>

@property (weak, nonatomic) IBOutlet UserProfileHeaderView *userProfileHeaderView;
@property (nonatomic) id<UITableViewDataSource> contentProvider;

@property (weak, nonatomic) IBOutlet UIView *footerView;

@end


@implementation ProfileViewController

@synthesize output;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Prepate table view insets.
    [self gh_prepareTableViewAppearance];
    
    // Notify presenter layer to fetch some data.
    [self.output viewReadyForInteractions];
}

- (void)setContentProvider:(id<UITableViewDataSource>)contentProvider {
    
    // Set and save current content provider.
    self.tableView.dataSource = _contentProvider = contentProvider;
    
    //
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationFade];
    
    //
    [self.refreshControl endRefreshing];
}

- (void)gh_activateUnauthorizedState {
    
    // Disable scroll.
    self.tableView.scrollEnabled = NO;
    
    // Hide footer with data.
    self.footerView.hidden = YES;
    
    // Reset profile view state.
    [self.userProfileHeaderView resetState];
}

- (void)gh_activateAuthorizedState {
    
    // Disable scroll.
    self.tableView.scrollEnabled = YES;
    
    // Hide footer with data.
    self.footerView.hidden = NO;
}

#pragma mark - Appearance Helpers - 

- (void)gh_prepareTableViewAppearance {
    
    // Apply table view insets accourding to bar sizes.
    CGFloat topInset = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat bottomInset = self.tabBarController.tabBar.bounds.size.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
}
 
#pragma - Presenter Layer Feedback -

- (void)showActivity {
    [self.refreshControl beginRefreshing];
}

- (void)showUnauthorizedState {
    // TODO: Create unauthorized content provider
    self.contentProvider = [UnauthorizedContentProvider contentProviderWithDelegate:self];
    
    // Move to unauthorized state
    [self gh_activateUnauthorizedState];
}

- (void)showNoContentState {
    // TODO: Create no data content provider
    self.contentProvider = [NoDataContentProvider new];
    
    // Move to authorized state.
    [self gh_activateAuthorizedState];
}

- (void)showUserAvatar:(UIImage *)avatar {
    [self.userProfileHeaderView setUserAvararImage:avatar];
}

- (void)showRepositories:(NSArray<RepositoryRecord *> *)repositories {
    // TODO: Create repositories content provider.
    self.contentProvider = [RepositoriesContentProvider contentProviderWithRepositories:repositories];
}

- (void)showUserProfile:(UserProfileRecord *)userProfile {
    // TODO: Apply user profile to UserProfileHeaderView
    
    [self.userProfileHeaderView setUserName:userProfile.userName];
}

- (void)showSignOutAlert {
    
    UIAlertController *alertController = [UIAlertController signOutAlertWithResponse:^{
        [self.output userDidAcceptSignOut];
    }];
    
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - User Input -

- (IBAction)onRefreshAction:(id)sender {
    [self.output userWantsLatestData];
}

- (IBAction)onSignOutAction:(id)sender {
    [self.output userWantsToSignOut];
}

#pragma mark - UnauthorizedContentProviderDelegate -

- (void)onSignInAction {
    [self.output userWantsToSignIn];
}

@end
