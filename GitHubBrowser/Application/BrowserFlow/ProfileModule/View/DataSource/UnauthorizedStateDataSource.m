//
//  UnauthorizedStateDataSource.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UnauthorizedStateDataSource.h"

#import "UITableViewCell+Usability.h"
#import "UnauthorizedTableViewCell.h"


@interface UnauthorizedStateDataSource ()
@property (nonatomic, weak) id<UnauthorizedStateDataSourceDelegate> delegate;
@end

@implementation UnauthorizedStateDataSource

+ (id<UITableViewDataSource>)dataSourceWithDelegate:(id<UnauthorizedStateDataSourceDelegate>)delegate {
    
    UnauthorizedStateDataSource *contentProvider = [UnauthorizedStateDataSource new];
    contentProvider.delegate = delegate;
    return contentProvider;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UnauthorizedTableViewCell *cell = [UnauthorizedTableViewCell reusableCell:tableView];
    
    __weak typeof(self) _self = self;
    [cell setSignInActionBlock:^{
        [_self.delegate onSignInAction];
    }];
    
    return cell;
}

@end
