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

/*!
 *
 */
@interface ProfileViewController () <UnauthorizedContentProviderDelegate>

@property (weak, nonatomic) IBOutlet UserProfileHeaderView *userProfileHeaderView;
@property (nonatomic) id<UITableViewDataSource> contentProvider;

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
    _contentProvider = contentProvider;
    self.tableView.dataSource = contentProvider;
    
    [self.tableView reloadData];
    
    //
    [self.refreshControl endRefreshing];
}

#pragma mark - Appearance Helpers - 

- (void)gh_prepareTableViewAppearance {
    
    // Apply table view insets accourding to bar sizes.
    CGFloat topInset = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat bottomInset = self.tabBarController.tabBar.bounds.size.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
    
    // Allow self-sizing for cells.
    self.tableView.estimatedRowHeight = 86;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
}

#pragma - Presenter Layer Feedback -

- (void)showUnauthorizedState {
    // TODO: Create unauthorized content provider
    self.contentProvider = [UnauthorizedContentProvider contentProviderWithDelegate:self];
    self.tableView.bounces = NO;
}

- (void)showNoContentState {
    // TODO: Create no data content provider
    self.contentProvider = [NoDataContentProvider new];
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
}

#pragma mark - User Input -

- (IBAction)onRefreshAction:(id)sender {
    [self.output userWantsLatestData];
}

- (IBAction)onLogoutAction:(id)sender {
    [self.output userWantsToSignOut];
}

#pragma mark - UnauthorizedContentProviderDelegate -

- (void)onSignInAction {
    [self.output userWantsToSignIn];
}

@end
