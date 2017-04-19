//
//  RepositoriesDataSource.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "RepositoriesDataSource.h"

#import "UITableViewCell+Usability.h"
#import "RepositoryTableViewCell.h"

#import "RepositoryRecord.h"

@interface RepositoriesDataSource ()
@property (nonatomic) NSArray<RepositoryRecord *> *repositories;
@end

@implementation RepositoriesDataSource

+ (instancetype)dataSourceWithRepositories:(NSArray<RepositoryRecord *> *)repositories {
    return [[self alloc] initWithRepositories:repositories];
}

- (instancetype)initWithRepositories:(NSArray<RepositoryRecord *> *)repositories
{
    self = [super init];
    if (self) {
        self.repositories = repositories;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _repositories.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    RepositoryRecord *repository = [_repositories objectAtIndex:indexPath.row];
    RepositoryTableViewCell *cell = [RepositoryTableViewCell reusableCell:tableView];
    
    [cell setRepositoryName:repository.name];
    [cell setRepositoryDescription:repository.desc?:NSLocalizedString(@"No description.", nil)];
    [cell setLanguage:repository.language];
    
    [cell setAuthorName:repository.ownerName];
    
    [cell setStars:repository.starsCount];
    [cell setColorPosition: (indexPath.row + 1) / (CGFloat)_repositories.count];
    
    return cell;
}

@end
