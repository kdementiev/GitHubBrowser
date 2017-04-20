//
//  NetworkingAsyncOperationAdapter.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/20/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "NetworkingAsyncOperationAdapter.h"


@interface NetworkingAsyncOperationAdapter ()
@property (nonatomic) NSURLSessionDataTask *dataTask;
@end

@implementation NetworkingAsyncOperationAdapter

+ (instancetype)asyncOperationWithSessionDtaTask:(NSURLSessionDataTask *)dataTask {
    NetworkingAsyncOperationAdapter *asyncOperation = [NetworkingAsyncOperationAdapter new];
    asyncOperation.dataTask = dataTask;
    return asyncOperation;
}

- (void)cancelOperation {
    [super cancelOperation];
    
    // Cancel wrapped operation.
    [_dataTask cancel];
}

@end
