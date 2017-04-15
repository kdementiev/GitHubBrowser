//
//  RepositoryTableViewCell.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "RepositoryTableViewCell.h"

@interface RepositoryTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@end

@implementation RepositoryTableViewCell

- (void)setRepositoryName:(NSString *)name {
    self.titleLabel.text = name;
}

- (void)setRepositoryDescription:(NSString *)description {
    self.descriptionLabel.text = description;
}

@end
