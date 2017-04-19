//
//  SearchQueryEntity.h
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/19/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface SearchQueryEntity : NSManagedObject

@property (nonatomic) NSString *query;
@property (nonatomic) NSDate *queryDate;

@end
