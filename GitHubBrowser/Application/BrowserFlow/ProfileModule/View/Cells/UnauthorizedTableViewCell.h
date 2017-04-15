//
//  UnauthorizedTableViewCell.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/15/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^UnauthorizedCellSignInActionCallback)();


@interface UnauthorizedTableViewCell : UITableViewCell

- (void)setSignInActionBlock:(UnauthorizedCellSignInActionCallback)callback;

@end
