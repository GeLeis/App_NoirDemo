//
//  RunloopTaskTool.m
//  LogNSNullRegex
//
//  Created by gelei on 2020/6/10.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "RunloopTaskTool.h"

@interface RunloopTaskTool ()
/**
 存放任务的数组
 */
@property (nonatomic, strong) NSMutableArray *tasks;

/**
 任务标记
 */
@property (nonatomic, strong) NSMutableArray *taskKeys;

@end

@implementation RunloopTaskTool

static RunloopTaskTool *_taskTool = nil;
+ (RunloopTaskTool *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _taskTool = [[RunloopTaskTool alloc] init];
        _taskTool.maxTaskCount = 20;
        [_taskTool addRunloopObserver];
    });
    return _taskTool;
}
//添加任务
- (void)addTask:(void(^)(void))task withKey:(id)key {
    [self removeTaskByKey:key];
    [self.tasks addObject:task];
    [self.taskKeys addObject:key];
    if (self.tasks.count > self.maxTaskCount) {
        [self.tasks removeObjectAtIndex:0];
        [self.taskKeys removeObjectAtIndex:0];
    }
}
//根据key移除task
- (void)removeTaskByKey:(id)key {
    if ([self.taskKeys containsObject:key]) {
        [self.tasks removeObjectAtIndex:[self.taskKeys indexOfObject:key]];
        [self.taskKeys removeObject:key];
    }
}

- (void)addRunloopObserver {
    CFRunLoopObserverContext context = {
        0,
        ( __bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //监听runloop即将进入睡眠状态
    static CFRunLoopObserverRef defaultModeObsever;
    defaultModeObsever = CFRunLoopObserverCreate(NULL,
                                                 kCFRunLoopAllActivities,
                                                 YES,
                                                 NSIntegerMax,
                                                 &Callback,
                                                 &context
                                                 );
    
    //添加RunLoop的观察者
    CFRunLoopAddObserver(CFRunLoopGetMain(), defaultModeObsever, kCFRunLoopCommonModes);
    CFRelease(defaultModeObsever);
    
}

//定义一个回调函数
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    BOOL resume = NO;
    if (activity == kCFRunLoopBeforeWaiting) {
//        NSLog(@"kCFRunLoopBeforeWaiting");
        resume = YES;
    }
//    else {
//        NSLog(@"activity = %lu",activity);
//    }
    
    RunloopTaskTool *taskTool = (__bridge RunloopTaskTool *)(info);
    if (resume && taskTool.tasks.count) {
        void(^task)(void) = taskTool.tasks.firstObject;
        //执行任务
//        dispatch_async(dispatch_get_main_queue(), task);
        task();
        [taskTool.tasks removeObjectAtIndex:0];
        [taskTool.taskKeys removeObjectAtIndex:0];
    }
}

- (NSMutableArray *)tasks {
    if (!_tasks) {
        _tasks = [[NSMutableArray alloc] init];
    }
    return _tasks;
}

- (NSMutableArray *)taskKeys {
    if (!_taskKeys) {
        _taskKeys = [[NSMutableArray alloc] init];
    }
    return _taskKeys;
}

@end
