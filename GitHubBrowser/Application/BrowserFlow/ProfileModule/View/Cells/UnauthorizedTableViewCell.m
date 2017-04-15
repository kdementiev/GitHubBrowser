//
//  UnauthorizedTableViewCell.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "UnauthorizedTableViewCell.h"

@interface UnauthorizedTableViewCell ()

@property (nonatomic) UnauthorizedCellSignInActionCallback signInCallback;

@end


@implementation UnauthorizedTableViewCell

- (IBAction)onSignInAction:(id)sender {
    if (_signInCallback) {
        _signInCallback();
    }
}

- (void)setSignInActionBlock:(UnauthorizedCellSignInActionCallback)callback {
    self.signInCallback = callback;
}

@end
