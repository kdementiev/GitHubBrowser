//
//  GHUserEntity.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GHUserEntity : JSONModel

@property (nonatomic) NSInteger userId;

@property (nonatomic) NSString *login;
@property (nonatomic) NSString *avatarUrl;

@property (nonatomic) NSString *bio;

@property (nonatomic) NSInteger publicRepos;
@property (nonatomic) NSInteger followers;
@property (nonatomic) NSInteger following;

@end
