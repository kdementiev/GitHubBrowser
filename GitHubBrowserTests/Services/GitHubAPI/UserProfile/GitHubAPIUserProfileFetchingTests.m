//
//  GitHubAPIUserProfileFetchingTests.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHUserProfileTestCase.h"

@interface GitHubAPIUserProfileFetchingTests : GHUserProfileTestCase
@property (nonatomic) NSString *token;
@end

@implementation GitHubAPIUserProfileFetchingTests

- (void)setUp {
    [super setUp];
    self.token = @"TestToken";
}

- (void)tearDown {
    [super tearDown];
}

- (void)testTokenIntegration {
    
    [self.userProfileService prepareWithUserToken:_token];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Request expectation."];
    [self simulateResponseWithJSON:@""
                             route:nil
                            status:200
                           headers:nil
                           request:^(NSString *route, NSDictionary *headers, NSDictionary *body) {
                               
                               NSString *tokenQuery = [NSString stringWithFormat:@"access_token=%@", _token];
                               XCTAssertTrue([route containsString:tokenQuery], @"No token in request url found.");
                               
                               [responseExpectation fulfill];
                           }];
    
    [self.userProfileService fetchUserProfileWithResponse:^(UserProfileRecord * _Nullable userProfile) {
    }];
    
    [self waitForExpectations];
}

- (void)testUserProfileFetchingSuccess {
    
    [self simulateSuccessResponseWithJSON:@"github_profile_fetch_response_200.json"];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    [self.userProfileService fetchUserProfileWithResponse:^(UserProfileRecord * _Nullable userProfile) {
        
        XCTAssertNotNil(userProfile, @"Invalid response instance.");
        XCTAssertTrue([userProfile isKindOfClass:[UserProfileRecord class]], @"Inavalid response instance type.");
        
        XCTAssertTrue([userProfile.userName isEqualToString:@"kdementiev"], @"Incorrect user name.");
        
        XCTAssertTrue([userProfile.avatarUrl isEqualToString:@"https://avatars2.githubusercontent.com/u/15383282?v=3"], @"Incorrect avatar url.");
        
        XCTAssertEqual(userProfile.publicRepositoriesCount, 7, @"Incorrect repositories count");
        XCTAssertEqual(userProfile.followersCount, 0, @"Incorrect followers count");
        XCTAssertEqual(userProfile.followingCount, 2, @"Incorrect following count");
        
        [responseExpectation fulfill];
    }];
    
    
    [self waitForExpectations];
}

- (void)testUserProfileFetchingUnauthorized {
    
    [self simulateResponseWithJSON:@"github_fetch_response_401.json" route:nil status:401];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    [self.userProfileService fetchUserProfileWithResponse:^(UserProfileRecord * _Nullable userProfile) {

        XCTAssertNil(userProfile, @"Response object must be nil.");
    
        [responseExpectation fulfill];
    }];
    
    
    [self waitForExpectations];
}

@end
