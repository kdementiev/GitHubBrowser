//
//  MediaAsyncOperationAdapted.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AsyncOperation.h"

@protocol SDWebImageOperation;

@interface MediaAsyncOperationAdapted : AsyncOperation

+ (instancetype)asyncOperationWithMediaOperation:(id<SDWebImageOperation>)operation;

@end
