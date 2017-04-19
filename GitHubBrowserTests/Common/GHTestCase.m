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

#import <OHHTTPStubs/NSURLRequest+HTTPBodyTesting.h>


NSInteger const GHTestCaseSuccessResponseCode = 200;
NSTimeInterval const GHTestCaseExpectationsTimeout = 3.0;

@implementation GHTestCase

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    [super tearDown];
    
    // Remove all stubs.
    [self clearSimulations];
}

- (void)simulateSuccessResponseWithJSON:(NSString*)fileName {
    [self simulateResponseWithJSON:fileName route:nil status:GHTestCaseSuccessResponseCode];
}

- (void)simulateResponseWithJSON:(NSString *)fileName route:(NSString *)route status:(NSUInteger)status {
    [self simulateResponseWithJSON:fileName route:route status:status headers:nil request:nil];
}

- (void)simulateResponseWithJSON:(NSString *)fileName route:(NSString *)route status:(NSUInteger)status headers:(NSDictionary *)headers request:(GHTestCaseNetworkingRequestCallback)callback {
    
    [OHHTTPStubs stubRequestsPassingTest:^BOOL(NSURLRequest *request) {
        return !route ? YES : [request.URL.absoluteString containsString:route];
        
    } withStubResponse:^OHHTTPStubsResponse*(NSURLRequest *request) {
        
        if (callback) {
            
            NSDictionary* jsonDict;
            
            if (request.OHHTTPStubs_HTTPBody) {
                jsonDict = [NSJSONSerialization JSONObjectWithData:request.OHHTTPStubs_HTTPBody
                                                           options:kNilOptions
                                                             error:nil];
            }
            
            callback(request.URL.absoluteString, request.allHTTPHeaderFields, jsonDict);
        }

        NSMutableDictionary *requiredHeaders = [NSMutableDictionary dictionaryWithObject:@"application/json" forKey:@"Content-Type"];
        [requiredHeaders addEntriesFromDictionary:headers];
        
        NSString* fixture = OHPathForFile(fileName, self.class);
        return [OHHTTPStubsResponse responseWithFileAtPath:fixture
                                                statusCode:(int)status
                                                   headers:requiredHeaders];
    }];
}

- (void)clearSimulations {
    [OHHTTPStubs removeAllStubs];
}

- (void)waitForExpectations {
    [self waitForExpectationsWithTimeout:GHTestCaseExpectationsTimeout handler:nil];
}

     
@end
