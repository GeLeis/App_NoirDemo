//
//  NSTimer+YLT_Extension.m
//  BlackCard
//
//  Created by 项普华 on 2018/4/11.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "NSTimer+YLT_Extension.h"

@implementation NSTimer (YLT_Extension)

- (void)ylt_pause {
    if (!self.isValid) return;
    [self setFireDate:[NSDate distantFuture]];
}

- (void)ylt_resume {
    if (!self.isValid) return;
    [self setFireDate:[NSDate date]];
}

- (void)ylt_resumeWithTimeInterval:(NSTimeInterval)time {
    if (!self.isValid) return;
    [self setFireDate:[NSDate dateWithTimeIntervalSinceNow:time]];
}

@end

