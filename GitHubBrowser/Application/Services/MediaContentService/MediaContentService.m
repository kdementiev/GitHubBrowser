//
//  MediaContentService.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "MediaContentService.h"

#import <SDWebImage/SDWebImageManager.h>

@implementation MediaContentService

- (nonnull BFTask<UIImage *> *)fetchImageMediaFromLink:(nonnull NSString*)link {
    
    NSAssert(link != nil, @"Link must not be nil. Please provide correct link.");
    
    BFTaskCompletionSource<UIImage *> *taskComplition = [BFTaskCompletionSource taskCompletionSource];
    
    SDInternalCompletionBlock loadCallback = ^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, SDImageCacheType cacheType, BOOL finished, NSURL * _Nullable imageURL) {
        
        if (image) {
            [taskComplition setResult:image];
        } else {
            [taskComplition setError:error];
        }
    };
    
    NSURL *imageURL = [NSURL URLWithString:link];
    id<SDWebImageOperation> operation = [[SDWebImageManager sharedManager] loadImageWithURL:imageURL
                                                                                    options:SDWebImageHighPriority
                                                                                   progress:nil
                                                                                  completed:loadCallback];
    
    return [taskComplition.task continueWithBlock:^id _Nullable(BFTask<UIImage *> * _Nonnull t) {
        if (t.isCancelled) {
            [operation cancel];
        }
        return nil;
    }];
}

@end
