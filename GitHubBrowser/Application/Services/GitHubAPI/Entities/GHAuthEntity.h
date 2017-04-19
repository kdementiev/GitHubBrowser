//
//  GHAuthEntity.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/17/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface GHAuthEntity : JSONModel

@property (nonatomic) NSInteger authId;

@property (nonatomic) NSString *token;
@property (nonatomic) NSString *hashedToken;

@end
