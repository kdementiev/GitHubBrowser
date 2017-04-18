//
//  GHRepositoryEntity.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHRepositoryEntity.h"

@implementation GHRepositoryEntity

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper baseMapper:[JSONKeyMapper mapperForSnakeCase]
           withModelToJSONExceptions:@{
                                       @"desc": @"description"
                                       }];
}

@end
