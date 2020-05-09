//
//  UIApplication+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by 項普華 on 2019/4/9.
//

#import "UIApplication+YLT_Extension.h"

@implementation UIApplication (YLT_Extension)

static void *mainQueueKey = &mainQueueKey;
static void *mainQueueContext = &mainQueueContext;
/**
 是否是主队列
 
 @return 注意区分主队列与主线程
 */
+ (BOOL)ylt_isMainQueue {
    static dispatch_once_t ylt_isMainQueueOnceToken;
    dispatch_once(&ylt_isMainQueueOnceToken, ^{
        dispatch_queue_set_specific(dispatch_get_main_queue(),
                                    mainQueueKey, mainQueueContext, NULL);
    });
    
    return dispatch_get_specific(mainQueueKey) == mainQueueKey;
}

+ (void *)ylt_mainQueueKey {
    [self ylt_isMainQueue];
    return mainQueueKey;
}

+ (void *)ylt_mainQueueContext {
    [self ylt_isMainQueue];
    return mainQueueContext;
}

@end
