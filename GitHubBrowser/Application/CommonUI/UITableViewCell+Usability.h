//
//  UITableViewCell+Usability.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/16/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableViewCell (Usability)

/*!
 *  @disscussion Offers simple way to register UITableViewCell from .xib to UITableView.
 *  @param tableView UITableView instance with will be used as owner of this cell.
 *  @return Intance of the current class using dequeueReusableCellWithIdentifier: method.
 */
+ (instancetype)reusableCell:(UITableView *)tableView;

/*!
 *  @disscussion Offers simple way to register UITableViewCell from .xib to UITableView.
 *  @param tableView UITableView instance with will be used as owner of this cell.
 */
+ (void)registerCell:(UITableView *)tableView;

@end
