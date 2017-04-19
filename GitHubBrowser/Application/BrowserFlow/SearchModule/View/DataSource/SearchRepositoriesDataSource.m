//
//  SearchRepositoriesDataSource.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "SearchRepositoriesDataSource.h"

@implementation SearchRepositoriesDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Search results:", nil);
}

@end
