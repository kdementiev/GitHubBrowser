//
//  NotFoundStateContentProvider.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "NotFoundStateContentProvider.h"

NSString * const NotFoundStateContentProviderCellIdentifier = @"NothingFoundTableViewCell";

@implementation NotFoundStateContentProvider

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:NotFoundStateContentProviderCellIdentifier];
}

@end
