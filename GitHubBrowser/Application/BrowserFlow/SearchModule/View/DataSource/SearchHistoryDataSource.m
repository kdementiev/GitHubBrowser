//
//  SearchHistoryDataSource.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "SearchHistoryDataSource.h"

#import "UITableViewCell+Usability.h"

#import "InfoHeaderTableViewCell.h"
#import "QueryTableViewCell.h"

@interface SearchHistoryDataSource ()

@property (nonatomic, weak) id<SearchHistoryDataSourceDelegate> delegate;
@property (nonatomic) NSArray<NSString *> *queries;

@end

@implementation SearchHistoryDataSource

+ (instancetype)dataSourceWithQueriesList:(NSArray<NSString *> *)queries delegate:(id<SearchHistoryDataSourceDelegate>)delegate {
    return [[self alloc] initWithQueriesList:queries delegate:delegate];
}

- (instancetype)initWithQueriesList:(NSArray<NSString *> *)queries delegate:(id<SearchHistoryDataSourceDelegate>)delegate
{
    self = [super init];
    if (self) {
        self.queries = queries;
        self.delegate = delegate;
    }
    return self;
}

#pragma mark - Table Content -

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return NSLocalizedString(@"Recent search:", nil);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _queries.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    QueryTableViewCell *cell = [QueryTableViewCell reusableCell:tableView];
    cell.queryLabel.text = [_queries objectAtIndex:indexPath.row];
    return cell;
}

#pragma mark - Table Events -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (_queries) {
        NSString *searchQuery = [_queries objectAtIndex:indexPath.row];
        [self.delegate onSearchQuerySelected:searchQuery];
    }
}

@end
