//
//  GHUserEntity.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHUserEntity.h"

@implementation GHUserEntity

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper baseMapper:[JSONKeyMapper mapperForSnakeCase]
           withModelToJSONExceptions:@{
                                       @"userId": @"id"
                                       }];
}

@end
