//
//  RepositoryTableViewCell.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "RepositoryTableViewCell.h"

#import <UIColorInterpolation/UIColor+Interpolation.h>


@interface RepositoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UILabel *languageLabel;
@property (weak, nonatomic) IBOutlet UILabel *starsLabel;

@property (nonatomic) IBInspectable UIColor *topColor;
@property (nonatomic) IBInspectable UIColor *bottomColor;

@end

@implementation RepositoryTableViewCell

- (void)setRepositoryName:(NSString *)name {
    self.titleLabel.text = name;
}

- (void)setRepositoryDescription:(NSString *)description {
    self.descriptionLabel.text = description;
}

- (void)setLanguage:(NSString *)language {
    self.languageLabel.text = language;
}

- (void)setStars:(NSInteger)stars {
    self.starsLabel.text = [NSString stringWithFormat:@"%li", (long)stars];
}

- (void)setColorPosition:(CGFloat)position {
    self.contentView.backgroundColor = [_topColor colorByInterpolatingWith:_bottomColor factor:position];
}

@end
