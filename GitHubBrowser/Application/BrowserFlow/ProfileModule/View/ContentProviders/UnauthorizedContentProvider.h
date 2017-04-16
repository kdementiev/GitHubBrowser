//
//  UnauthorizedContentProvider.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UnauthorizedContentProviderDelegate <NSObject>
- (void)onSignInAction;
@end

@interface UnauthorizedContentProvider : NSObject<UITableViewDataSource>

+ (id<UITableViewDataSource>)contentProviderWithDelegate:(id<UnauthorizedContentProviderDelegate>)delegate;

@end
