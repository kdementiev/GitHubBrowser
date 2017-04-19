//
//  InfoHeaderTableViewCell.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "InfoHeaderTableViewCell.h"

@interface InfoHeaderTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *infoLabel;

@end

@implementation InfoHeaderTableViewCell

- (void)setInfoMessage:(NSString *)message {
    _infoLabel.text = [message stringByAppendingString:@":"];
}

@end
