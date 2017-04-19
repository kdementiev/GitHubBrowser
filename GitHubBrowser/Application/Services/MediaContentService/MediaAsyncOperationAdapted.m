//
//  MediaAsyncOperationAdapted.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "MediaAsyncOperationAdapted.h"

#import <SDWebImage/SDWebImageManager.h>


@interface MediaAsyncOperationAdapted ()
@property (nonatomic) id<SDWebImageOperation> operation;
@end

@implementation MediaAsyncOperationAdapted

+ (instancetype)asyncOperationWithMediaOperation:(id<SDWebImageOperation>)operation {
    MediaAsyncOperationAdapted *asyncOperation = [MediaAsyncOperationAdapted new];
    asyncOperation.operation = operation;
    return asyncOperation;
}

- (void)cancelOperation {
    [super cancelOperation];
    
    // Cancel wrapped operation.
    [_operation cancel];
}

@end
