//
//  GitHubAPIAuthentication.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GitHubAPIAuthentication.h"

#import "GitHubAPINetworking.h"

NSString * const GitHubAPIAutorizationsRoute = @"authorizations/%li";
NSString * const GitHubAPIClientAuthorizationRoute = @"authorizations/clients/";

NSString * const GitHubAPIAppNameNote = @"GitHubBrowser iOS app";

// Header values
NSString * const GitHubAPIOTPHeader = @"X-GitHub-OTP";
NSString * const GitHubAPIOTPHeaderSMSValue = @"sms";

@implementation GitHubAPIAuthentication

+ (void)authenticateWithName:(NSString *)name
                    password:(NSString *)password
                         otp:(NSString *)otp
                    response:(GitHubAPIAuthenticationCredentialsResponseCallback)callback
{
    
    NSString *route = [GitHubAPIClientAuthorizationRoute stringByAppendingString:gitHubNetworking.clientId];
    
    NSDictionary *requestParams = @{
                                    @"client_secret":gitHubNetworking.clientSecret,
                                    @"note":GitHubAPIAppNameNote
                                    };
    
    if (otp) {
        [gitHubNetworking addHeaderField:GitHubAPIOTPHeader withValue:otp];
    }
    
    [gitHubNetworking performPUT:route
                          params:requestParams
                           class:[GHAuthEntity class]
                        response:^(NSError *error, id responseObject, NSDictionary *headers) {
                            
                            GitHubAPIAuthenticationTwoFactorType type = GitHubAPIAuthenticationTwoFactorNone;
                            
                            NSString *otpHeaderValue = [headers valueForKey:GitHubAPIOTPHeader];
                            
                            if (otpHeaderValue) {
                                type = [otpHeaderValue containsString:GitHubAPIOTPHeaderSMSValue] ? GitHubAPIAuthenticationTwoFactorSMS : GitHubAPIAuthenticationTwoFactorApplication ;
                            }
                            
                            callback(responseObject, type);
                            
                        }];
}

+ (void)deleteAuthorizationWithId:(NSInteger)identifier response:(GitHubAPIAuthenticationResponseCallback)response {
    
    NSString *route = [NSString stringWithFormat:GitHubAPIAutorizationsRoute, identifier];
    
    [gitHubNetworking performDELETE:route
                             params:nil
                              class:nil
                           response:^(NSError *error, id responseObject, NSDictionary *headers) {
                               
                           }];
    
}

@end
