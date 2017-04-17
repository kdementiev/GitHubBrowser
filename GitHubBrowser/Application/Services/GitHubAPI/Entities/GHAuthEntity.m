//
//  GHAuthEntity.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHAuthEntity.h"

@implementation GHAuthEntity

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper baseMapper:[JSONKeyMapper mapperForSnakeCase]
           withModelToJSONExceptions:@{
                                       @"authId": @"id"
                                       }];
}

@end
