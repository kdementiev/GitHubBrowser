//
//  LocalStorageService.m
//  GitHubBrowser
//
//  Created by Konstantin Dementiev on 4/18/17.
//  Copyright © 2017 Konstantin Dementiev. All rights reserved.
//

#import "LocalStorageService.h"

#import <CoreData/CoreData.h>
#import "SearchQueryEntity.h"

//
NSString * const LocalStorageServiceStorageName = @"SearchHistoryStorage";

@interface LocalStorageService ()

@property (nonatomic, strong) NSPersistentContainer *searchHistoryContainer;

@end


@implementation LocalStorageService

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

#pragma mark - Core Data Lazy Initialization -


- (NSPersistentContainer *)searchHistoryContainer {
    
    if (!_searchHistoryContainer) {
        _searchHistoryContainer = [NSPersistentContainer persistentContainerWithName:LocalStorageServiceStorageName];
        
        [_searchHistoryContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription * _Nonnull desc, NSError * _Nullable error) {
            if (error) {
                NSLog(@"Error occured: %@", error);
            }
        }];
    }
    
    return _searchHistoryContainer;
}

#pragma mark - Service Controls -

- (void)saveSearchQuery:(nonnull NSString *)query {

    [self.searchHistoryContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
        
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([SearchQueryEntity class])];
        [fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"query == %@", query]];
        
        NSError *error;
        NSArray<SearchQueryEntity *> *result = [context executeFetchRequest:fetchRequest error:&error];
        
        if (result.count) {
            NSLog(@"Duplicated query.");
            return;
        }
        
        SearchQueryEntity *queryEntity = [[SearchQueryEntity alloc] initWithContext:context];
        queryEntity.query = query;
        queryEntity.queryDate = [NSDate date];
        
        if (![context save:&error]) {
            NSLog(@"Error occured: %@", error);
        }
    }];
}

- (nonnull AsyncOperation *)fetchSearchQueriesWithResponse:(nonnull SearchHistoryLocalStorageResponseCallback)callback {
    
    NSAssert(callback != nil, @"Please provide response callback.");
    
    __weak typeof(self) _self = self;
    [self.searchHistoryContainer performBackgroundTask:^(NSManagedObjectContext * _Nonnull context) {
       
        NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"queryDate" ascending:NO];
        
        NSFetchRequest *queriesRequest = [NSFetchRequest fetchRequestWithEntityName:NSStringFromClass([SearchQueryEntity class])];
        [queriesRequest setSortDescriptors:@[descriptor]];
        
        NSError *error;
        NSArray<SearchQueryEntity *> *queries = [context executeFetchRequest:queriesRequest error:&error];
        
        if (error) {
            NSLog(@"Error occured: %@", error);
        }

        [_self gh_processFetchQueriesResult:queries response:callback];
    }];
    
    return nil;
}

- (void)gh_processFetchQueriesResult:(NSArray<SearchQueryEntity *> *)queries response:(nonnull SearchHistoryLocalStorageResponseCallback)callback {
    
    NSMutableArray<NSString *> *history = [NSMutableArray array];
    
    [queries enumerateObjectsUsingBlock:^(SearchQueryEntity * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [history addObject:obj.query];
    }];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        callback(history);
    });
}

@end






