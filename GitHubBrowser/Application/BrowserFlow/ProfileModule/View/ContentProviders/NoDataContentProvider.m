//
//  NoDataContentProvider.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "NoDataContentProvider.h"

#import "UITableViewCell+Usability.h"
#import "InfoMessageTableViewCell.h"

@implementation NoDataContentProvider

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    InfoMessageTableViewCell *cell = [InfoMessageTableViewCell reusableCell:tableView];
    return cell;
}


@end
