//
//  AsyncOperation.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AsyncOperation : NSObject

@property (nonatomic, readonly) BOOL canceled;

- (void)cancelOperation;

@end
