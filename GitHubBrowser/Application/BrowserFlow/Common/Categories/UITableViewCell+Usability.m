//
//  UITableViewCell+Usability.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UITableViewCell+Usability.h"

@implementation UITableViewCell (Usability)

+ (instancetype)reusableCell:(UITableView *)tableView {
    
    NSString *cellIdentifier = NSStringFromClass([self class]);
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (!cell) {
        [[self class] registerCell:tableView];
        cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    }
    
    return cell;
}

+ (void)registerCell:(UITableView *)tableView {
    
    NSString *className = NSStringFromClass([self class]);
    
    UINib *cellNib = [UINib nibWithNibName:className bundle:nil];
    [tableView registerNib:cellNib forCellReuseIdentifier:className];
}

@end
