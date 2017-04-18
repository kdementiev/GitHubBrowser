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
    
    // Prepare GitHub auth service
    self.authService = [GitHubAuthenticationService new];
    
    // Prepare credentials.
    self.credentials = [AuthCredentials authCredentialsWithUser:@"test" password:@"test" otpCode:@"1234"];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testLoginDefaultFlow {
    
    [self simulateSuccessResponseWithJSON:@"guthub_auth_default_response_200.json"];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    
    [_authService loginWithCredentials:_credentials
                              response:^(NSString * _Nullable authToken, AuthenticationServiceResponseError error) {
                                  
                                  //
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
                           headers:@{@"X-GitHub-OTP": @"required; sms"}
                           request:^(NSString *route, NSDictionary *headers, NSDictionary *body) {
                               
                               // Test credentials
                               NSString *authValue = [headers valueForKey:@"Authorization"];
                               XCTAssertNotNil(authValue, @"No required field: Authorization");
                               XCTAssertTrue([authValue isEqualToString:@"Basic dGVzdDp0ZXN0"], @"Invalid Authorization header content.");
                               
                               NSString *otpValue = [headers valueForKey:@"X-GitHub-OTP"];
                               XCTAssertNotNil(otpValue, @"No required field: X-GitHub-OTP");
                               XCTAssertTrue([otpValue isEqualToString:self.credentials.otpCode], @"Invalid X-GitHub-OTP header content.");
                               
                           }];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    
    [_authService loginWithCredentials:_credentials
                              response:^(NSString * _Nullable authToken, AuthenticationServiceResponseError error) {
                                  
                                  XCTAssertNil(authToken, @"authToken must be nil.");
                                  XCTAssertEqual(error, AuthenticationServiceResponseErrorOTPRequired, @"Invalid response state.");
                                  
                                  [responseExpectation fulfill];
                              }];
    
    [self waitForExpectations];
}

- (void)testLoginBadCredentialsError {
    
    [self simulateResponseWithJSON:@"guthub_auth_bad_credentials_response_401.json"
                             route:@"authorizations/clients"
                            status:401];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    
    [_authService loginWithCredentials:_credentials
                              response:^(NSString * _Nullable authToken, AuthenticationServiceResponseError error) {
                                  
                                  XCTAssertNil(authToken, @"authToken must be nil.");
                                  XCTAssertEqual(error, AuthenticationServiceResponseErrorBadCredentials, @"Invalid response state.");
                                  
                                  [responseExpectation fulfill];
                              }];
    
    [self waitForExpectations];
}

@end
