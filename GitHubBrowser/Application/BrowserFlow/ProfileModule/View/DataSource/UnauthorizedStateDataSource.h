//
//  UnauthorizedStateDataSource.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnauthorizedStateDataSourceDelegate <NSObject>
- (void)onSignInAction;
@end

@interface UnauthorizedStateDataSource : NSObject<UITableViewDataSource>

+ (id<UITableViewDataSource>)dataSourceWithDelegate:(id<UnauthorizedStateDataSourceDelegate>)delegate;

@end
