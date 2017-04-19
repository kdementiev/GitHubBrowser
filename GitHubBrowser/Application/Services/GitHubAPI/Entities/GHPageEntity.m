//
//  GHPageEntity.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHPageEntity.h"

@implementation GHPageEntity

+ (BOOL)propertyIsOptional:(NSString *)propertyName {
    return YES;
}

+ (JSONKeyMapper *)keyMapper {
    return [JSONKeyMapper mapperForSnakeCase];
}


@end
