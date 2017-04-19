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
@property (nonatomic) NSArray<NSString *> *queries;
@end

@implementation SearchHistoryDataSource

+ (id<UITableViewDataSource>)dataSourceWithQueriesList:(NSArray<NSString *> *)queries {
    return [[self alloc] initWithQueriesList:queries];
}

- (instancetype)initWithQueriesList:(NSArray<NSString *> *)queries
{
    self = [super init];
    if (self) {
        self.queries = queries;
    }
    return self;
}

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

@end
