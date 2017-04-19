//
//  GitHubSearchService.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GitHubSearchService.h"

#import "GitHubAPINetworking.h"
#import "GHRepositoryPageEntity.h"

#import "RepositoryRecord+GitHub.h"

// Routes
NSString * const GitHubAPISearchRepositoriesRoute = @"search/repositories";

// Query params
NSString * const GitHubAPISeqrchQueryParamName = @"q";


@implementation GitHubSearchService

- (nonnull AsyncOperation *)searchRepositoriesWithText:(nonnull NSString *)text
                                              response:(nonnull SearchNetworkingSearchResultsCallback)callback {

    [gitHubNetworking performGET:GitHubAPISearchRepositoriesRoute
                          params:@{GitHubAPISeqrchQueryParamName: text}
                           class:[GHRepositoryPageEntity class]
                        response:^(NSError *error, id responseObject, NSDictionary *headers) {
                            
                            NSMutableArray<RepositoryRecord *> *repositories = [NSMutableArray array];
                            
                            if (responseObject) {
                                GHRepositoryPageEntity *page = responseObject;

                                [page.items enumerateObjectsUsingBlock:^(GHRepositoryEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                                    RepositoryRecord *repository = [RepositoryRecord repositoryRecordWithGitHubRepository:obj];
                                    [repositories addObject:repository];
                                }];
                            }
                            
                            callback(repositories);
                        }];
    
    return nil;
}

@end
