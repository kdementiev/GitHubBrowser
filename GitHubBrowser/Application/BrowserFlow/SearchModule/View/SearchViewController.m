//
//  SearchViewController.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "SearchViewController.h"

#import "ActivityStateDataSource.h"
#import "NotFoundStateContentProvider.h"

#import "SearchRepositoriesDataSource.h"
#import "SearchHistoryDataSource.h"


@interface SearchViewController () <UISearchBarDelegate, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) id<UITableViewDataSource> contentProvider;

@end

@implementation SearchViewController

@synthesize output;

- (void)viewDidLoad {
    [super viewDidLoad];

    //
    self.tableView.estimatedRowHeight = 82;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    // Notify that view ready.
    [self.output viewReadyForInteractions];
}

- (void)setContentProvider:(id<UITableViewDataSource>)contentProvider {
    
    // Set and save current content provider.
    self.tableView.dataSource = _contentProvider = contentProvider;
    
    // Reload table view animated.
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:0]
                  withRowAnimation:UITableViewRowAnimationFade];
}

#pragma mark - View Controls -

- (void)showEmpty {
    self.contentProvider = nil;
}

- (void)showNotFound {
    self.contentProvider = [NotFoundStateContentProvider new];
}

- (void)showSearchHistory:(NSArray<NSString *> *)historyList {
    self.contentProvider = [SearchHistoryDataSource dataSourceWithQueriesList:historyList];
}

- (void)showSearchResults:(NSArray<RepositoryRecord *> *)repositories {
    self.contentProvider = [SearchRepositoriesDataSource dataSourceWithRepositories:repositories];
}

- (void)showActivity {
    self.contentProvider = [ActivityStateDataSource new];
}

#pragma mark - UISearchBarDelegate -

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.output userWantsToSearchWithText:searchBar.text];
    
    [searchBar resignFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self gh_notifyWithUserWantsToCancelSearch];
    
    [searchBar resignFirstResponder];
    searchBar.text = nil;
}

#pragma mark - Notify Helpers -

- (void)gh_notifyWithUserWantsToCancelSearch {
    [self.output userWantsToCancelSearch];
}

@end
