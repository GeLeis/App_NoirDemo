//
//  UIApplication+YLT_Extension.h
//  YLT_BaseLib
//
//  Created by 項普華 on 2019/4/9.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIApplication (YLT_Extension)

/**
 是否是主队列

 @return 注意区分主队列与主线程
 */
+ (BOOL)ylt_isMainQueue;

+ (void *)ylt_mainQueueKey;

+ (void *)ylt_mainQueueContext;

@end

NS_ASSUME_NONNULL_END
