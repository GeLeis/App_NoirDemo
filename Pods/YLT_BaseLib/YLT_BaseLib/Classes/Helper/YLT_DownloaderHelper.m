//
//  YLT_DownloaderHelper.m
//  Pods
//
//  Created by YLT_Alex on 2018/1/15.
//

#import "YLT_DownloaderHelper.h"

@interface YLT_DownloaderHelper () {
}

/**
 timer
 */
@property (nonatomic, strong) NSTimer *timer;

/**
 存放任务的数组
 */
@property (nonatomic, strong) NSMutableArray *tasks;

/**
 任务标记
 */
@property (nonatomic, strong) NSMutableArray *taskKeys;

@end

@implementation YLT_DownloaderHelper

YLT_ShareInstance(YLT_DownloaderHelper);

- (void)ylt_init {
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.001 target:self selector:@selector(timerFiredMethod) userInfo:nil repeats:YES];
    [self addRunloopObserver];
    
}

//保持线程活跃
-(void)timerFiredMethod{
}

//添加任务
- (void)ylt_addTask:(BOOL(^)(void))task withKey:(id)key {
    [self.tasks addObject:task];
    [self.taskKeys addObject:key];
    if (self.tasks.count > self.ylt_maxCount) {
        [self.tasks removeObjectAtIndex:0];
        [self.taskKeys removeObjectAtIndex:0];
    }
}

//这里面都是C语言 -- 添加一个监听者
-(void)addRunloopObserver {
    //获取当前的RunLoop
    CFRunLoopRef runloop = CFRunLoopGetCurrent();
    //定义一个centext
    CFRunLoopObserverContext context = {
        0,
        ( __bridge void *)(self),
        &CFRetain,
        &CFRelease,
        NULL
    };
    //定义一个观察者
    static CFRunLoopObserverRef defaultModeObsever;
    //创建观察者
    defaultModeObsever = CFRunLoopObserverCreate(NULL,
                                                 kCFRunLoopBeforeWaiting,
                                                 YES,
                                                 NSIntegerMax - 999,
                                                 &Callback,
                                                 &context
                                                 );
    
    //添加当前RunLoop的观察者
    CFRunLoopAddObserver(runloop, defaultModeObsever, kCFRunLoopDefaultMode);
    //c语言有creat 就需要release
    CFRelease(defaultModeObsever);
    
}

//MARK: 回调函数
//定义一个回调函数  一次RunLoop来一次
static void Callback(CFRunLoopObserverRef observer, CFRunLoopActivity activity, void *info){
    YLT_DownloaderHelper *downloader = (__bridge YLT_DownloaderHelper *)(info);
    if (downloader.tasks.count == 0) {
        return;
    }
    BOOL result = NO;
    while (result == NO && downloader.tasks.count) {
        //取出任务
        BOOL(^unit)(void) = downloader.tasks.firstObject;
        //执行任务
        result = unit();
        //干掉第一个任务
        [downloader.tasks removeObjectAtIndex:0];
        //干掉标示
        [downloader.taskKeys removeObjectAtIndex:0];
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
