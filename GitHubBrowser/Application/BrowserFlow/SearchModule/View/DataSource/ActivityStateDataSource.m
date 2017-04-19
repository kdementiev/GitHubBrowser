//
//  ActivityStateDataSource.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ActivityStateDataSource.h"

#import "UITableViewCell+Usability.h"
#import "ActivityTableViewCell.h"


@implementation ActivityStateDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [ActivityTableViewCell reusableCell:tableView];
}

@end
