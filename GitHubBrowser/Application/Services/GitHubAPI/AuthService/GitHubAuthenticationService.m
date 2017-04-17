//
//  GitHubAuthenticationService.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GitHubAuthenticationService.h"

#import "GitHubAPINetworking.h"
#import "GHAuthEntity.h"

// Routes
NSString * const GitHubAPIAutorizationsRoute = @"authorizations/%li";
NSString * const GitHubAPIClientAuthorizationRoute = @"authorizations/clients/";

// Formats data.
NSString * const GitHubAuthBaseTokenFormat = @"%@:%@";
NSString * const GitHubAuthBaseHeaderFormat = @"Basic %@";

// Header values
NSString * const GitHubAPIBaseAuthHeader = @"Authorization";
NSString * const GitHubAPIOTPHeader = @"X-GitHub-OTP";

// Values
NSString * const GitHubAPIApplicationNoteValue = @"GitHubBrowser iOS app";


typedef void(^AuthServiceResponseCallback)(BOOL success);


@implementation GitHubAuthenticationService

- (void)loginWithCredentials:(nonnull AuthCredentials *)credentials response:(nonnull AuthServiceLoginResponseCallback)callback {
    
    NSAssert(credentials.userName, @"User name must be provided.");
    NSAssert(credentials.password, @"Password must be provided.");
    
    NSString *route = [GitHubAPIClientAuthorizationRoute stringByAppendingString:gitHubNetworking.clientId];
    
    // Bad. Must be mapped by object.
    NSDictionary *requestParams = @{@"client_secret":gitHubNetworking.clientSecret,
                                    @"note":GitHubAPIApplicationNoteValue};
    
    if (credentials.otpCode) {
        [gitHubNetworking addHeaderField:GitHubAPIOTPHeader withValue:credentials.otpCode];
    }
    
    NSString *baseAuthToken = [self gh_base64TokenFromCredentials:credentials];
    if (baseAuthToken) {
        [gitHubNetworking addHeaderField:GitHubAPIBaseAuthHeader withValue:baseAuthToken];
    }
    
    __weak typeof(self) _self = self;
    [gitHubNetworking performPUT:route
                          params:requestParams
                           class:[GHAuthEntity class]
                        response:^(NSError *error, id responseObject, NSDictionary *headers) {
                            
                            if ([headers valueForKey:GitHubAPIOTPHeader]) {
                                callback(nil, AuthenticationServiceResponseErrorOTPRequired);
                                return;
                            }
                            
                            if (error) {
                                callback(nil, AuthenticationServiceResponseErrorBadCredentials);
                                return;
                            }
                            
                            GHAuthEntity *authEntity = (GHAuthEntity*)responseObject;
                            if (!authEntity.token.length) {
                                
                                // TODO: Perform auth delete and then re-login.
                                [_self gh_deleteAuthorizationWithId:authEntity.authId response:^(BOOL success) {
                                    if (success) {
                                        [_self loginWithCredentials:credentials response:callback];
                                        return;
                                    }
                                    
                                    callback(nil, AuthenticationServiceResponseErrorBadCredentials);
                                }];
                                
                                return;
                            }
                            
                            callback(authEntity.token, AuthenticationServiceResponseErrorNone);
                        }];
}

- (void)gh_deleteAuthorizationWithId:(NSInteger)identifier response:(nonnull AuthServiceResponseCallback)callback {
    
    NSString *route = [NSString stringWithFormat:GitHubAPIAutorizationsRoute, (long)identifier];
    
    [gitHubNetworking performDELETE:route
                             params:nil
                              class:nil
                           response:^(NSError *error, id responseObject, NSDictionary *headers) {
                               callback(error == nil);
                           }];
}

- (NSString *)gh_base64TokenFromCredentials:(AuthCredentials *)credentials {
    
    // Transform our string to NSData, it helps us with base64 encoding.
    NSString *authData = [NSString stringWithFormat:GitHubAuthBaseTokenFormat, credentials.userName, credentials.password];
    
    // Use native base64 encoder.
    NSString *base64Token = [[authData dataUsingEncoding:NSUTF8StringEncoding] base64EncodedStringWithOptions:kNilOptions];
    
    // Put token to Basic Authentication format.
    return [NSString stringWithFormat:GitHubAuthBaseHeaderFormat, base64Token];
}


@end
