//
//  UserProfileRecord.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserProfileRecord : NSObject

@property (nonatomic) NSString *userName;
@property (nonatomic) NSString *avatarUrl;

@property (nonatomic) NSInteger publicRepositoriesCount;
@property (nonatomic) NSInteger followersCount;
@property (nonatomic) NSInteger followingCount;

@end
