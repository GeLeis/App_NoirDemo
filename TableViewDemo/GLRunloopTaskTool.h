//
//  RunloopTaskTool.h
//  LogNSNullRegex
//
//  Created by gelei on 2020/6/10.
//  Copyright © 2020 gelei. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GLRunloopTaskTool : NSObject
+ (GLRunloopTaskTool *)shareInstance;

- (void)addTask:(void(^)(void))task;

- (void)addTarget:(id)target task:(void(^)(void))task;

/// 添加runloop任务
/// @param target 执行任务的关联目标
/// @param uniqueKey 任务的唯一key,防止对同一个对象添加相同的任务
/// @param task 任务
- (void)addTarget:(id)target uniqueKey:(NSString *)uniqueKey task:(void(^)(void))task;

- (void)remvoeTasks:(id)target;

- (void)remvoeAllTasks;
@end
