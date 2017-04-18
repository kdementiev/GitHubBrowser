//
//  GitHubAPISearchTests.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GHTestCase.h"
#import "GitHubSearchService.h"

#import "RepositoryRecord.h"

@interface GitHubAPISearchTests : GHTestCase
@property (nonatomic) GitHubSearchService *searchService;
@end

@implementation GitHubAPISearchTests

- (void)setUp {
    [super setUp];
    
    self.searchService = [GitHubSearchService new];
}

- (void)tearDown {
    [super tearDown];
}

- (void)testSearchSuccess {
    
    [self simulateResponseWithJSON:@"github_search_response_200.json"
                             route:@"search/repositories"
                            status:200
                           headers:nil
                           request:^(NSString *route, NSDictionary *headers, NSDictionary *body) {
                               NSString *query = [[route componentsSeparatedByString:@"?"] lastObject];
                               XCTAssertTrue([query isEqualToString:@"?q=GitHubBrowser"], @"Invalid request query.");
                           }];
    
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Search response expectation."];
    
    SearchNetworkingSearchResultsCallback responseBlock = ^(NSArray<RepositoryRecord *> * _Nullable repositories) {
        
        XCTAssertNotNil(repositories, @"Response object should not be nil.");
        XCTAssertTrue([repositories isKindOfClass:[NSArray class]], @"Invalid response instance type.");
        
        XCTAssertEqual(repositories.count, 2, @"Invalid repositories count");
        
        // Test repository mapping.
        RepositoryRecord *repository = [repositories firstObject];
        
        XCTAssertTrue([repository isKindOfClass:[RepositoryRecord class]], @"Invalid repository instance type.");
        XCTAssertTrue([repository.name isEqualToString:@"GithubBrowser"], @"Invalid repository name");
        
        XCTAssertTrue([repository.desc isEqualToString:@"A Github Browser For iPad"], @"Invalid repository description");
        XCTAssertEqual(repository.starsCount, 28, @"Invalid repository stars count.");
        
        [responseExpectation fulfill];
    };
    
    [_searchService searchRepositoriesWithText:@"GitHubBrowser"
                                      response:responseBlock];
    
    [self waitForExpectations];
}

- (void)testSearchNotFound {
    
    [self simulateSuccessResponseWithJSON:@"github_search_notfound_response_200.json"];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Search response expectation."];
    
    SearchNetworkingSearchResultsCallback responseBlock = ^(NSArray<RepositoryRecord *> * _Nullable repositories) {
        
        XCTAssertNotNil(repositories, @"Response object should not be nil.");
        XCTAssertTrue([repositories isKindOfClass:[NSArray class]], @"Invalid response instance type.");
        XCTAssertEqual(repositories.count, 0, @"Invalid repositories count");
        
        [responseExpectation fulfill];
    };
    
    [_searchService searchRepositoriesWithText:@""
                                      response:responseBlock];
    
    [self waitForExpectations];
}

- (void)testSearchValidationFailed {
    
    [self simulateSuccessResponseWithJSON:@"github_search_invalid_response_422.json"];
    
    XCTestExpectation *responseExpectation = [self expectationWithDescription:@"Search response expectation."];
    
    SearchNetworkingSearchResultsCallback responseBlock = ^(NSArray<RepositoryRecord *> * _Nullable repositories) {
        
        XCTAssertNotNil(repositories, @"Response object should not be nil.");
        XCTAssertTrue([repositories isKindOfClass:[NSArray class]], @"Invalid response instance type.");
        XCTAssertEqual(repositories.count, 0, @"Invalid repositories count");
        
        [responseExpectation fulfill];
    };
    
    [_searchService searchRepositoriesWithText:@""
                                      response:responseBlock];
    
    [self waitForExpectations];
}

- (void)testSearchOperationCancelation {
    
    [self simulateSuccessResponseWithJSON:@"github_search_response_200.json"];
    
    SearchNetworkingSearchResultsCallback responseBlock = ^(NSArray<RepositoryRecord *> * _Nullable repositories) {
        XCTFail(@"Task was not canceled.");
    };
    
    // Fire request.
    AsyncOperation *operation = [_searchService searchRepositoriesWithText:@"" response:responseBlock];
    
    // Cancel async operation.
    [operation cancelOperation];
    
    // We need to wait for stub.
    sleep(3);
}

@end
