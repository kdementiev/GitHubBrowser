//
//  GitHubAPIAuthenticationTests.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "GHTestCase.h"
#import "GitHubAuthenticationService.h"

@interface GitHubAPIAuthenticationTests : GHTestCase

@property (nonatomic) GitHubAuthenticationService *authService;
@property (nonatomic) AuthCredentials *credentials;

@end

@implementation GitHubAPIAuthenticationTests

- (void)setUp {
    [super setUp];
    
    self.authService = [GitHubAuthenticationService new];
    
    self.credentials = [AuthCredentials authCredentialsWithUser:@"test" password:@"test" otpCode:nil];
}

- (void)tearDown {
    
    [super tearDown];
}

- (void)testLoginDefaultFlow {
    
    [self simulateSuccessResponseWithJSON:@"guthub_auth_default_response_200.json"];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response received."];
    
    [_authService loginWithCredentials:_credentials
                              response:^(NSString * _Nullable authToken, AuthenticationServiceResponseError error) {
                                  
                                  XCTAssertNotNil(authToken, @"authToken must not be nil.");
                                  XCTAssertEqual(error, AuthenticationServiceResponseErrorNone, @"Invalid response state.");
                                  
                                  XCTAssertTrue([authToken isEqualToString:@"52fe1f630a4474517c75ead56eaa"], @"Invalid token.");
                                  
                                  [responseExpectation fulfill];
                              }];
    
    [self waitForExpectations];
}

- (void)testLoginTwoFactorFlow {
    
    [self simulateResponseWithJSON:@"guthub_auth_otp_response_401.json"
                             route:@"authorizations/clients"
                            status:401
                           headers:@{@"X-GitHub-OTP": @"required; sms"}];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response received."];
    
    [_authService loginWithCredentials:_credentials
                              response:^(NSString * _Nullable authToken, AuthenticationServiceResponseError error) {
                                  
                                  XCTAssertNil(authToken, @"authToken must be nil.");
                                  XCTAssertEqual(error, AuthenticationServiceResponseErrorOTPRequired, @"Invalid response state.");
                                  
                                  [responseExpectation fulfill];
                              }];
    
    [self waitForExpectations];
}

@end
