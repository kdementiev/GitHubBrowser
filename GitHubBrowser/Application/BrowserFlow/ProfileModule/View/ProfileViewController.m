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
#import "UnauthorizedTableViewCell.h"
#import "RepositoryTableViewCell.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UserProfileHeaderView *userProfileHeaderView;

@end

@implementation ProfileViewController

@synthesize output;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Prepate table view insets.
    [self gh_prepareTableViewAppearance];
    
    // Notify presenter layer to fetch some data.
    [self.output onUserWantsLatestData];
}

- (void)viewDidAppear:(BOOL)animated {
    [self.output onUserWantsToSignIn];
}

- (void)gh_prepareTableViewAppearance {
    
    CGFloat topInset = [UIApplication sharedApplication].statusBarFrame.size.height;
    CGFloat bottomInset = self.tabBarController.tabBar.bounds.size.height;
    
    self.tableView.contentInset = UIEdgeInsetsMake(topInset, 0, bottomInset, 0);
}


#pragma - Presenter Layer Feedback -

- (void)showUnauthorizedState {
    
}

#pragma mark - User Input -

- (IBAction)onRefreshAction:(id)sender {
    
}

#pragma mark - UITableViewDataSource -

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

@end
