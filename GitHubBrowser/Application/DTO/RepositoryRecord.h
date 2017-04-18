//
//  RepositoryRecord.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RepositoryRecord : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *desc;

@property (nonatomic) NSString *language;
@property (nonatomic) NSInteger starsCount;

@end
