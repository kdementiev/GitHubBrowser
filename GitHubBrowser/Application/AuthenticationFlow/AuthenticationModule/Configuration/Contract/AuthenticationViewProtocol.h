//
//  AuthenticationViewProtocol.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <Foundation/Foundation.h>


// Events from view
@protocol AuthenticationViewDelegate <NSObject>

- (void)userWantsToCancel;


@end

// Provides ability to controll view
@protocol AuthenticationViewProtocol <NSObject>

// Strong because we need to own output to support our structure.
@property (nonatomic, strong) id<AuthenticationViewDelegate> output;

@end
