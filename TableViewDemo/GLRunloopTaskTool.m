//
//  RunloopTaskTool.m
//  LogNSNullRegex
//
//  Created by gelei on 2020/6/10.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "GLRunloopTaskTool.h"

@interface GLRunloopTaskTool ()

@property (nonatomic, strong) NSMapTable *taskCache;
/** 无target的自增长index */
@property (nonatomic, assign) int increase_Index;
@property (nonatomic, strong) NSMutableArray *targetsCache;
@end

@implementation GLRunloopTaskTool

static GLRunloopTaskTool *_taskTool = nil;
+ (GLRunloopTaskTool *)shareInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _taskTool = [[GLRunloopTaskTool alloc] init];
        //key为target,value为@{@"key":key,@"task":task},这样单target释放时,task也会被移除
        //如果没有传target,那么则自动生成key
        _taskTool.taskCache = [[NSMapTable alloc] initWithKeyOptions:NSPointerFunctionsWeakMemory valueOptions:NSPointerFunctionsStrongMemory capacity:0];
        [_taskTool addRunloopObserver];
    });
    return _taskTool;
}

+ (void)addTask:(void(^)(void))task {
    [self addTarget:nil task:task];
}

+ (void)addTarget:(id)target task:(void(^)(void))task {
    [self addTarget:target uniqueKey:nil task:task];
}
//添加任务
+ (void)addTarget:(id)target uniqueKey:(NSString *)uniqueKey task:(void(^)(void))task {
    GLRunloopTaskTool *taskTool = [GLRunloopTaskTool shareInstance];
    //如果target存在task,查看是否需要检查uniqueKey
    id tar = target ? : taskTool;
    NSMutableDictionary *taskInfo = [taskTool.taskCache objectForKey:tar];
    if (!taskInfo) {
        taskInfo = [NSMutableDictionary dictionary];
        [taskTool.taskCache setObject:taskInfo forKey:tar];
    }
    if (uniqueKey) {
        [taskInfo setObject:task forKey:uniqueKey];
    } else {
        NSString *key = [NSString stringWithFormat:@"gl_runloop_task_tool_value_%d",taskTool.increase_Index % INT_MAX];
        [taskInfo setObject:task forKey:key];
    }
    taskTool.increase_Index++;
}

+ (void)removeTasks:(id)target {
    GLRunloopTaskTool *taskTool = [GLRunloopTaskTool shareInstance];
    id tar = target ? : taskTool;
    [taskTool.taskCache removeObjectForKey:tar];
}

+ (void)removeAllTasks {
    [[GLRunloopTaskTool shareInstance].taskCache removeAllObjects];
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
                                                 kCFRunLoopBeforeWaiting,
                                                 YES,
                                                 INT_MAX,
                                                 &Callback,
                                                 &context
                                                 );
    
    //添加RunLoop的观察者
    CFRunLoopAddObserver(CFRunLoopGetMain(), defaultModeObsever, kCFRunLoopCommonModes);
    CFRelease(defaultModeObsever);
    
}

//定义一个回调函数
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    GLRunloopTaskTool *taskTool = (__bridge GLRunloopTaskTool *)(info);
    if (taskTool.taskCache.count) {
//        NSLog(@"start task");
        id target = taskTool.taskCache.keyEnumerator.allObjects.firstObject;
//        NSLog(@"target = %@",target);
        NSMutableDictionary *taskInfo = [taskTool.taskCache objectForKey:target];
//        NSLog(@"taskInfo start = %@",taskInfo);
        NSString *taskKey = taskInfo.allKeys.firstObject;
        void(^task)(void) = [taskInfo objectForKey:taskKey];
        if (task) {
            //执行任务
            task();
//            NSLog(@"excute task=%@",task);
        }
        [taskInfo removeObjectForKey:taskKey];
//        NSLog(@"taskInfo end = %@",taskInfo);
        if (taskInfo.count == 0) {
            [taskTool.taskCache removeObjectForKey:target];
//            NSLog(@"taskInfo.count== %lu,taskCache.count=%lu",(unsigned long)taskInfo.count,(unsigned long)taskTool.taskCache.count);
        }
        if (taskTool.taskCache.count) {
            CFRunLoopWakeUp(CFRunLoopGetMain());
        }
    }
}

- (NSMutableArray *)targetsCache {
    if (!_targetsCache) {
        _targetsCache = [NSMutableArray array];
    }
    return _targetsCache;
}

@end
