//
//  GLSocketManager.h
//  TableViewDemo
//
//  Created by gelei on 2020/7/23.
//  Copyright © 2020 gelei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GLSocketManager : NSObject
+ (instancetype)defaultManager;
- (void)connect;
- (void)sendMessage:(NSString *)message;
@end

NS_ASSUME_NONNULL_END
