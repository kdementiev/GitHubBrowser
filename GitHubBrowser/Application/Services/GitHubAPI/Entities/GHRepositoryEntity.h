//
//  GHRepositoryEntity.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GHRepositoryEntity : JSONModel

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;

@property (nonatomic) NSString *language;
@property (nonatomic) NSInteger stargazersCount;

@end
