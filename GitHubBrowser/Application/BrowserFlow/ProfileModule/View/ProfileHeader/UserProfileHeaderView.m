//
//  UserProfileHeaderView.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UserProfileHeaderView.h"

@interface UserProfileHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end


@implementation UserProfileHeaderView

- (void)setUserAvararImage:(UIImage *)image {
    
    _avatarImageView.image = image;
    
    [UIView animateKeyframesWithDuration:1.0f
                                   delay:1.0f
                                 options:UIViewKeyframeAnimationOptionCalculationModeCubic
                              animations:^{
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.0 relativeDuration:0.5 animations:^{
                                      _avatarImageView.alpha = 0.5f;
                                  }];
                                  
                                  [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
                                      _avatarImageView.alpha = 1.0f;
                                  }];
                                  
                              }
                              completion:nil];
    
}

@end
