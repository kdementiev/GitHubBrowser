//
//  GHTestCase.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHTestCase.h"

#import <OHHTTPStubs/OHHTTPStubs.h>
#import <OHHTTPStubs/OHPathHelpers.h>

NSInteger const GHTestCaseSuccessResponseCode = 200;
NSTimeInterval const GHTestCaseExpectationsTimeout = 3.0;

@implementation GHTestCase

- (void)setUp {
    [super setUp];
}

- (void)simulateSuccessResponseWithJSON:(NSString*)fileName {
    [self simulateResponseWithJSON:fileName route:nil status:GHTestCaseSuccessResponseCode];
}

- (void)simulateResponseWithJSON:(NSString *)fileName route:(NSString *)route status:(NSUInteger)status {
    [self simulateResponseWithJSON:fileName route:route status:status headers: @{@"Content-Type":@"application/json"}];
}

- (void)simulateResponseWithJSON:(NSString *)fileName route:(NSString *)route status:(NSUInteger)status headers:(NSDictionary *)headers {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return !route ? YES : [request.URL.absoluteString containsString:route];
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        
        NSString* fixture = OHPathForFile(fileName, self.class);
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:(int)status
                                                   headers:headers];
    }];
}

- (void)waitForExpectations {
    [self waitForExpectationsWithTimeout:GHTestCaseExpectationsTimeout handler:nil];
}

     
@end
