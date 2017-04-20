//
//  NetworkingAsyncOperationAdapter.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/20/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "AsyncOperation.h"

@class NSURLSessionDataTask;

@interface NetworkingAsyncOperationAdapter : AsyncOperation

+ (instancetype)asyncOperationWithSessionDtaTask:(NSURLSessionDataTask *)dataTask;

@end
