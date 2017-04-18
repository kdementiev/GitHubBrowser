//
//  GitHubAPIUserProfileRepositoriesTests.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHUserProfileTestCase.h"

@interface GitHubAPIUserProfileRepositoriesTests : GHUserProfileTestCase
@end

@implementation GitHubAPIUserProfileRepositoriesTests

- (void)setUp {
    [super setUp];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRepositoriesFetchingSuccess {
    
    [self simulateResponseWithJSON:@"github_profile_fetch_response_401.json" route:@"user/repos" status:200];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    [self.userProfileService fetchUserRepositories:^(NSArray<RepositoryRecord *> * _Nullable repositories) {
        
        XCTAssertNotNil(repositories, @"Response object must not be nil.");
        XCTAssertTrue([repositories isKindOfClass:[NSArray class]], @"Invalid response object type.");
        XCTAssertEqual(repositories.count, 7, @"Incorrect repositories count");
        
        RepositoryRecord *repositoryRecord = [repositories objectAtIndex:3];
        XCTAssertTrue([repositoryRecord isKindOfClass:[RepositoryRecord class]], @"Invalid reposirtory instance type.");
        
        XCTAssertTrue([repositoryRecord.name isEqualToString:@"GitHubBrowser"], @"");
        XCTAssertNil(repositoryRecord.desc, @"");
        XCTAssertTrue([repositoryRecord.language isEqualToString:@"Objective-C"], @"");
        XCTAssertEqual(repositoryRecord.starsCount, 0, @"");

        [responseExpectation fulfill];
    }];
    
    [self waitForExpectations];
}

- (void)testRepositoriesFetchingUnauthorized {
    
    [self simulateResponseWithJSON:@"github_fetch_response_401.json" route:@"user/repos" status:401];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Response expectation."];
    [self.userProfileService fetchUserRepositories:^(NSArray<RepositoryRecord *> * _Nullable repositories) {
        XCTAssertNil(repositories, @"Response object must be nil.");
        [responseExpectation fulfill];
    }];
    
    [self waitForExpectations];
}


@end
