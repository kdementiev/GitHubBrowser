//
//  AsyncOperation.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AsyncOperation.h"

@implementation AsyncOperation

- (void)cancelOperation {
    _canceled = YES;
}

@end
