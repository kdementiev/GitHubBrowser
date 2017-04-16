//
//  UnauthorizedContentProvider.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UnauthorizedContentProvider.h"

#import "UITableViewCell+Usability.h"
#import "UnauthorizedTableViewCell.h"


@interface UnauthorizedContentProvider ()

@property (nonatomic, weak) id<UnauthorizedContentProviderDelegate> delegate;

@end


@implementation UnauthorizedContentProvider

+ (id<UITableViewDataSource>)contentProviderWithDelegate:(id<UnauthorizedContentProviderDelegate>)delegate {
    
    UnauthorizedContentProvider *contentProvider = [UnauthorizedContentProvider new];
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
