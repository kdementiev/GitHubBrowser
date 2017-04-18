//
//  GitHubAPIUserProfileFetchingTests.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHTestCase.h"

#import "GitHubUserProfileService.h"


@interface GitHubAPIUserProfileFetchingTests : GHTestCase

@property (nonatomic) GitHubUserProfileService *userProfileService;

@end

@implementation GitHubAPIUserProfileFetchingTests

- (void)setUp {
    [super setUp];
    
    
    self.userProfileService = [GitHubUserProfileService new];
    
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testUserProfileFetchingSuccess {
    
    [self simulateSuccessResponseWithJSON:@"github_profile_fetch_response_200.json"];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    [_userProfileService fetchUserProfileWithResponse:^(UserProfileRecord * _Nullable userProfile) {
        
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
    
    [self simulateResponseWithJSON:@"github_profile_fetch_response_401.json" route:nil status:401];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    [_userProfileService fetchUserProfileWithResponse:^(UserProfileRecord * _Nullable userProfile) {

        XCTAssertNil(userProfile, @"Response object must be nil.");
        
        [responseExpectation fulfill];
    }];
    
    
    [self waitForExpectations];
    
}

@end
