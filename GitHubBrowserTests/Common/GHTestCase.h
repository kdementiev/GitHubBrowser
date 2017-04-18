//
//  GHTestCase.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <XCTest/XCTest.h>

typedef void(^GHTestCaseNetworkingRequestCallback)(NSString *route, NSDictionary *headers, NSDictionary *body);

@interface GHTestCase : XCTestCase

- (void)simulateSuccessResponseWithJSON:(NSString*)fileName;
- (void)simulateResponseWithJSON:(NSString *)fileName route:(NSString *)route status:(NSUInteger)status;
- (void)simulateResponseWithJSON:(NSString *)fileName route:(NSString *)route status:(NSUInteger)status headers:(NSDictionary *)headers request:(GHTestCaseNetworkingRequestCallback)callback;

- (void)waitForExpectations;

@end
