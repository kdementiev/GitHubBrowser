//
//  TokenStorageServiceProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TokenStorageServiceProtocol <NSObject>

- (void)saveTokenToSecureStorage:(nullable NSString *)token;
- (nullable NSString *)fetchTokenFromSecureStorage;

@end
