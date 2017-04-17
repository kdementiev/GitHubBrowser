//
//  GitHubAPIAuthentication.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GitHubAPIAuthentication.h"



@implementation GitHubAPIAuthentication

+ (void)authenticateWithName:(NSString *)name
                    password:(NSString *)password
                         otp:(NSString *)otp
                    response:(GitHubAPIAuthenticationCredentialsResponseCallback)callback
{

}

+ (void)deleteAuthorizationWithId:(NSInteger)identifier response:(GitHubAPIAuthenticationResponseCallback)response {
    
//    NSString *route = [NSString stringWithFormat:GitHubAPIAutorizationsRoute, identifier];
//    
//    [gitHubNetworking performDELETE:route
//                             params:nil
//                              class:nil
//                           response:^(NSError *error, id responseObject, NSDictionary *headers) {
//                               
//                           }];
    
}

@end
