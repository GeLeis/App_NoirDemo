//
//  NSNotificationCenter+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by 項普華 on 2019/5/6.
//

#import "NSNotificationCenter+YLT_Extension.h"

@implementation NSNotificationCenter (YLT_Extension)

- (id <NSObject>)ylt_addObserverForName:(nullable NSNotificationName)name usingBlock:(void (^)(NSNotification *note))block {
    return [self addObserverForName:name object:nil queue:nil usingBlock:block];
}

- (void)ylt_postNotificationName:(NSNotificationName)aName object:(void(^)(id object))callback {
    [self postNotificationName:aName object:callback];
}

- (void)ylt_postNotificationName:(NSNotificationName)aName object:(void(^)(id object))callback userInfo:(nullable NSDictionary *)aUserInfo {
    [self postNotificationName:aName object:callback userInfo:aUserInfo];
}

@end
