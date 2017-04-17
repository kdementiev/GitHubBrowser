//
//  GitHubAPINetworking.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "GitHubAPINetworking.h"

#import <AFNetworking/AFNetworking.h>
#import <JSONModel/JSONModel.h>

// Default server url
NSString * const GitHubAPINetworkingDefaultServerURL = @"https://api.github.com/";

// Plist params
NSString * const GitHubAPINetworkingInfoPlistKey = @"GitHubCredentials";
NSString * const GitHubAPINetworkingInfoPlistClient = @"Client";
NSString * const GitHubAPINetworkingInfoPlistSecret = @"Secret";


@interface GitHubAPINetworking ()

@property (nonatomic) AFHTTPSessionManager *sessionManager;

@end


@implementation GitHubAPINetworking

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    static GitHubAPINetworking *instance;
    
    dispatch_once(&onceToken, ^{
        
        // Try to get API Key from Info.plist.
        NSDictionary *settingsDict = [[NSBundle mainBundle] objectForInfoDictionaryKey:GitHubAPINetworkingInfoPlistKey];
        NSString *clientId = [settingsDict objectForKey:GitHubAPINetworkingInfoPlistClient];
        NSString *clientSecret = [settingsDict objectForKey:GitHubAPINetworkingInfoPlistSecret];
        
        
        instance = [[GitHubAPINetworking alloc] initWithServerDomain:GitHubAPINetworkingDefaultServerURL
                                                            clientId:clientId
                                                        clientSecret:clientSecret];
    });
    
    return instance;
}

- (instancetype)initWithServerDomain:(NSString *)domain clientId:(NSString *)client clientSecret:(NSString *)secret
{
    self = [super init];
    if (self) {
        
        // Save cretentials
        _clientId = client;
        _clientSecret = secret;
        
        // Prepare session manager
        NSURL *baseURL = [NSURL URLWithString:domain];
        self.sessionManager = [[AFHTTPSessionManager alloc] initWithBaseURL:baseURL];
        
        // Prepare caching
        [self gh_prepareChachingPolicy];
    }
    return self;
}

#pragma mark - Working with headers -

- (void)addHeaderField:(NSString *)field withValue:(NSString *)value {
    [_sessionManager.requestSerializer setValue:value forHTTPHeaderField:field];
}

- (void)removeHeaderField:(NSString *)field {
    [_sessionManager.requestSerializer setValue:nil forHTTPHeaderField:field];
}

#pragma mark - Caching -

- (void)gh_prepareChachingPolicy {
    
    __weak typeof(self) _self = self;
    [_sessionManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [_self gh_validateCachingPolicyWithStatus:status];
    }];
    
    [_sessionManager.reachabilityManager startMonitoring];
}

- (void)gh_validateCachingPolicyWithStatus:(AFNetworkReachabilityStatus)status {
    _sessionManager.requestSerializer.cachePolicy = status ? NSURLRequestUseProtocolCachePolicy : NSURLRequestReturnCacheDataDontLoad;
}

#pragma mark - HTTP(S) Methods -

- (NSURLSessionDataTask *)performGET:(NSString*)route
                              params:(NSDictionary*)params
                               class:(Class)resultClass
                            response:(GitHubAPINetworkingResponseCallback)callback {
    
    NSURLSessionDataTask *task;
    
    task = [_sessionManager GET:route
                     parameters:params
                       progress:nil
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            [self gh_mapAndNotifyWithClass:resultClass content:responseObject task:task callback:callback];
                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            callback(error, nil, nil);
                        }];
    
    return task;
}


- (NSURLSessionDataTask *)performPUT:(NSString*)route
                              params:(NSDictionary*)params
                               class:(Class)resultClass
                            response:(GitHubAPINetworkingResponseCallback)callback {
    NSURLSessionDataTask *task;

    task = [_sessionManager PUT:route
                     parameters:params
                        success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                            [self gh_mapAndNotifyWithClass:resultClass content:responseObject task:task callback:callback];
                        }
                        failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                            callback(error, nil, nil);
                        }];
    return task;
}

- (NSURLSessionDataTask *)performDELETE:(NSString*)route params:(NSDictionary*)params class:(Class)resultClass response:(GitHubAPINetworkingResponseCallback)callback {
    
    
    NSURLSessionDataTask *task;
    
    task = [_sessionManager DELETE:route
                        parameters:params
                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                               [self gh_mapAndNotifyWithClass:resultClass content:responseObject task:task callback:callback];
                           }
                           failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                               callback(error, nil, nil);
                           }];
    return task;
    
}

#pragma mark - Private -

- (void)gh_mapAndNotifyWithClass:(Class)class
                         content:(id)responseObject
                         task:(NSURLSessionDataTask *)task
                        callback:(GitHubAPINetworkingResponseCallback)callback {
    
    if (!callback) {
        return;
    }
    
    NSHTTPURLResponse *response = ((NSHTTPURLResponse *)[task response]);
    NSDictionary *headers = [response allHeaderFields];
    
    NSError *error;
    id responseInstance = [[class alloc] initWithDictionary:responseObject error:&error];
    callback(error, responseInstance, headers);
}

@end
