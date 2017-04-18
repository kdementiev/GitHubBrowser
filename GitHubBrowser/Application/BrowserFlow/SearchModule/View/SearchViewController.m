//
//  SearchViewController.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "SearchViewController.h"

@interface SearchViewController () <UISearchBarDelegate, UITableViewDelegate>

@end

@implementation SearchViewController

@synthesize output;

- (void)viewDidLoad {
    [super viewDidLoad];

    // Notify that view ready.
    [self.output viewReadyForInteractions];
}

#pragma mark - View Controls -

- (void)showEmpty {
    
}

- (void)showNotFound {
    
}

- (void)showSearchHistory:(NSArray<NSString *> *)historyList {
    
}

- (void)showSearchResults:(NSArray<RepositoryRecord *> *)repositories {
    
}

#pragma mark - UISearchBarDelegate -

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [self.output userWantsToSearchWithText:searchBar.text];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    
    [self.output userWantsToCancelSearch];
    
    [searchBar resignFirstResponder];
    searchBar.text = nil;
}

@end
