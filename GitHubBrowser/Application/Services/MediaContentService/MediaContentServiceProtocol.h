//
//  MediaContentServiceProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AsyncOperation.h"

@class UIImage;

typedef void(^MediaContentServiceImageResponseCallback)(UIImage * _Nullable image);


@protocol MediaContentServiceProtocol <NSObject>

/*!
 *  @disscussion Offered method provide ability for image download, cancelation and caching.
 */
- (nonnull AsyncOperation *)fetchImageMediaFromLink:(nonnull NSString*)link response:(nonnull MediaContentServiceImageResponseCallback)callback;

@end
