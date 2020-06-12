//
//  RunloopTaskTool.h
//  LogNSNullRegex
//
//  Created by gelei on 2020/6/10.
//  Copyright © 2020 gelei. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RunloopTaskTool : NSObject
+ (RunloopTaskTool *)shareInstance;
/**
 最大保留任务数,默认20
 */
@property (nonatomic, assign) uint maxTaskCount;

/**
 添加任务,key存在,则删除原来key对应的task
 防止cell重用bug

 @param task 下载任务
 @param key 标记
 */
- (void)addTask:(void(^)(void))task withKey:(id)key;

//根据key移除task
- (void)removeTaskByKey:(id)key;
@end

NS_ASSUME_NONNULL_END
