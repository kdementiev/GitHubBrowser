//
//  TokenStorageService.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "TokenStorageService.h"

#import <SAMKeychain/SAMKeychain.h>


@interface TokenStorageService ()
@property (nonatomic) NSString *serviceName;
@end


@implementation TokenStorageService

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.serviceName = NSStringFromClass([TokenStorageService class]);
    }
    return self;
}

- (void)saveTokenToSecureStorage:(NSString *)token {
    
    [SAMKeychain setPassword:token
                  forService:_serviceName
                     account:_serviceName];
    
}

- (NSString *)fetchTokenFromSecureStorage {
    return [SAMKeychain passwordForService:_serviceName account:_serviceName];
}

@end
