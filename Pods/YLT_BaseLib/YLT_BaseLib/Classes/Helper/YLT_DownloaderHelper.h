//
//  YLT_DownloaderHelper.h
//  Pods
//
//  Created by YLT_Alex on 2018/1/15.
//

#import <Foundation/Foundation.h>
#import "YLT_BaseMacro.h"

@interface YLT_DownloaderHelper : NSObject

YLT_ShareInstanceHeader(YLT_DownloaderHelper);

/**
 同时支持的最大线程数量
 */
@property (nonatomic, assign) NSUInteger ylt_maxCount;

/**
 添加任务

 @param task 下载任务
 @param key 标记
 */
- (void)ylt_addTask:(BOOL(^)(void))task withKey:(id)key;

@end
