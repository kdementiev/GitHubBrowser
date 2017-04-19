//
//  ActivityTableViewCell.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "ActivityTableViewCell.h"

@interface ActivityTableViewCell ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@end

@implementation ActivityTableViewCell

- (void)prepareForReuse {
    [super prepareForReuse];
    
    // Show activity animation.
    [_activityIndicator startAnimating];
}

@end
