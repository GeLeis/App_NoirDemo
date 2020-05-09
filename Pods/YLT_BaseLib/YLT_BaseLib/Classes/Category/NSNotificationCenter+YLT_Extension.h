//
//  NSNotificationCenter+YLT_Extension.h
//  YLT_BaseLib
//
//  Created by 項普華 on 2019/5/6.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSNotificationCenter (YLT_Extension)

- (id <NSObject>)ylt_addObserverForName:(nullable NSNotificationName)name usingBlock:(void (^)(NSNotification *note))block;

- (void)ylt_postNotificationName:(NSNotificationName)aName object:(void(^)(id object))callback;

- (void)ylt_postNotificationName:(NSNotificationName)aName object:(void(^)(id object))callback userInfo:(nullable NSDictionary *)aUserInfo;

@end

NS_ASSUME_NONNULL_END
