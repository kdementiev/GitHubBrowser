//
//  UserProfileHeaderView.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserProfileHeaderView : UIView

- (void)setUserName:(NSString *)userName;
- (void)setUserAvararImage:(UIImage *)image;

- (void)resetState;

@end
