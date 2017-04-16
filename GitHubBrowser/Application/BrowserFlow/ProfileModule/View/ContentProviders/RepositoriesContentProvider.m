//
//  RepositoriesContentProvider.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "RepositoriesContentProvider.h"

#import "UITableViewCell+Usability.h"
#import "RepositoryTableViewCell.h"
#import "RepositoryRecord.h"

@interface RepositoriesContentProvider ()
@property (nonatomic) NSArray<RepositoryRecord *> *repositories;
@end


@implementation RepositoriesContentProvider

+ (id<UITableViewDataSource>)contentProviderWithRepositories:(NSArray<RepositoryRecord *> *)repositories {
    return [[RepositoriesContentProvider alloc] initWithRepositories:repositories];
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
    [cell setRepositoryDescription:repository.desc];
    
    return cell;
}

@end
