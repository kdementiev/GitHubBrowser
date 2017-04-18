//
//  RepositoryTableViewCell.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepositoryTableViewCell : UITableViewCell

- (void)setRepositoryName:(NSString *)name;
- (void)setRepositoryDescription:(NSString *)description;
- (void)setLanguage:(NSString *)language;

- (void)setStars:(NSInteger)stars;
- (void)setColorPosition:(CGFloat)position;

@end
