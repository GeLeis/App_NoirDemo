//
//  DataManager.m
//  TableViewDemo
//
//  Created by gelei on 2020/3/30.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager

static DataManager *_manager = nil;

+ (instancetype)dataManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _manager = [[DataManager alloc] init];
    });
    return _manager;
}

- (void)addFavorites:(NSDictionary *)data {
    [self.favorites addObject:data];
    [self saveDataInUD];
}

- (void)removeFavorites:(NSDictionary *)data {
    [self.favorites removeObject:data];
    [self saveDataInUD];
}

- (void)removeAll {
    [self.favorites removeAllObjects];
    [self saveDataInUD];
}

- (void)saveDataInUD {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
        [userDefault setValue:self.favorites forKey:@"pro_favorites"];
        [userDefault synchronize];
    });
}



- (NSMutableArray *)favorites {
    if (!_favorites) {
        _favorites = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:@"pro_favorites"]];
    }
    return _favorites;
}

@end
