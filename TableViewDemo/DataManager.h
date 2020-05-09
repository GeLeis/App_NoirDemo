//
//  DataManager.h
//  TableViewDemo
//
//  Created by gelei on 2020/3/30.
//  Copyright © 2020 gelei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DataManager : NSObject
@property (nonatomic,strong) NSMutableArray *favorites;
+ (instancetype)dataManager;

- (void)addFavorites:(NSDictionary *)data ;

- (void)removeFavorites:(NSDictionary *)data ;

- (void)removeAll;

@end

NS_ASSUME_NONNULL_END
