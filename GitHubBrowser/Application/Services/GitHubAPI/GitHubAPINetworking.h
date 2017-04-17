//
//  GitHubAPINetworking.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#define gitHubNetworking [GitHubAPINetworking sharedInstance]

typedef void(^GitHubAPINetworkingResponseCallback)(NSError *error, id responseObject, NSDictionary *headers);

@interface GitHubAPINetworking : NSObject

/*!
 *
 */
@property (nonatomic, readonly) NSString *clientId;

/*!
 *
 */
@property (nonatomic, readonly) NSString *clientSecret;

/*!
 *
 */
@property (nonatomic) NSString *token;

/*!
 *  @disscussion Offers access to default instance.
 */
+ (instancetype)sharedInstance;

/*!
 *  @disscussion Offers interface to initialize with specific server domain.
 *  @param domain GitHub server domain.
 *  @param client GitHub Auth application client id.
 *  @param secret GitHub Auth application client secret.
 */
- (instancetype)initWithServerDomain:(NSString *)domain clientId:(NSString *)client clientSecret:(NSString *)secret;

/*!
 *
 */
- (void)addHeaderField:(NSString *)field withValue:(NSString *)value;

/*!
 *
 */
- (void)removeHeaderField:(NSString *)field;

/*!
 *  @disscussion Offers interface to perform HTTP/HTTPS GET request.
 *  @param route HTTP/HTTPS Method path relative to domain.
 *  @param params Params provided in dictionary will be serialized to JSON.
 *  @param resultClass Class name. New instance will be created and mapped from response.
 *  @param callback Block offers ability to handle response event.
 *  @return NSURLSessionDataTask will be returned. Use this instance to control task lifecycle (cancel etc.).
 */
- (NSURLSessionDataTask *)performGET:(NSString*)route params:(NSDictionary*)params class:(Class)resultClass response:(GitHubAPINetworkingResponseCallback)callback;

/*!
 *  @disscussion Offers interface to perform HTTP/HTTPS PUT request.
 *  @param route HTTP/HTTPS Method path relative to domain.
 *  @param params Params provided in dictionary will be serialized to JSON.
 *  @param resultClass Class name. New instance will be created and mapped from response.
 *  @param callback Block offers ability to handle response event.
 *  @return NSURLSessionDataTask will be returned. Use this instance to control task lifecycle (cancel etc.).
 */
- (NSURLSessionDataTask *)performPUT:(NSString*)route params:(NSDictionary*)params class:(Class)resultClass response:(GitHubAPINetworkingResponseCallback)callback;

/*!
 *  @disscussion Offers interface to perform HTTP/HTTPS DELETE request.
 *  @param route HTTP/HTTPS Method path relative to domain.
 *  @param params Params provided in dictionary will be serialized to JSON.
 *  @param resultClass Class name. New instance will be created and mapped from response.
 *  @param callback Block offers ability to handle response event.
 *  @return NSURLSessionDataTask will be returned. Use this instance to control task lifecycle (cancel etc.).
 */
- (NSURLSessionDataTask *)performDELETE:(NSString*)route params:(NSDictionary*)params class:(Class)resultClass response:(GitHubAPINetworkingResponseCallback)callback;

@end
