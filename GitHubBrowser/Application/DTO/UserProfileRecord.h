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

@property (nonatomic) NSInteger publicRepos;
@property (nonatomic) NSInteger stars;
@property (nonatomic) NSInteger followers;
@property (nonatomic) NSInteger following;

@end
