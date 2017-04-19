//
//  MediaContentService.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "MediaContentService.h"

#import <SDWebImage/SDWebImageManager.h>
#import "MediaAsyncOperationAdapted.h"


@implementation MediaContentService

- (nonnull AsyncOperation *)fetchImageMediaFromLink:(nonnull NSString*)link response:(nonnull MediaContentServiceImageResponseCallback)callback {
    
    NSAssert(link != nil, @"Link must not be nil. Please provide correct link.");

    
    SDInternalCompletionBlock completeBlock = ^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        callback(image);
    };
    
    NSURL *imageURL = [NSURL URLWithString:link];
    id<SDWebImageOperation> operation = [[SDWebImageManager sharedManager] loadImageWithURL:imageURL
                                                                                    options:SDWebImageHighPriority
                                                                                   progress:nil
                                                                                  completed:completeBlock];
    
    return [MediaAsyncOperationAdapted asyncOperationWithMediaOperation:operation];
}

@end
