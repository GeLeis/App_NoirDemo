//
//  NSTimer+YLT_Extension.h
//  BlackCard
//
//  Created by 项普华 on 2018/4/11.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (YLT_Extension)

/**
 定时器暂停
 */
- (void)ylt_pause;

/**
 定时器开启
 */
- (void)ylt_resume;

/**
 定时间延时启动
 
 @param time 时间
 */
- (void)ylt_resumeWithTimeInterval:(NSTimeInterval)time;

@end

