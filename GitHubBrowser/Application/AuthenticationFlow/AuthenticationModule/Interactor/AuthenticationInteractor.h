//
//  AuthenticationInteractor.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "AuthenticationInteractorProtocol.h"

// Entity layer.
#import "AuthenticationServiceProtocol.h"
#import "CredentialsValidatorProtocol.h"

@interface AuthenticationInteractor : NSObject<AuthenticationInteractorProtocol>

@property (nonatomic) id<AuthenticationServiceProtocol> authService;
@property (nonatomic) id<CredentialsValidatorProtocol> credentialsValidator;

@end
