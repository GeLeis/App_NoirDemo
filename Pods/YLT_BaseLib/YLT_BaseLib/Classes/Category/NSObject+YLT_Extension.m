//
//  NSObject+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by YLT_Alex on 2017/10/25.
//

#import "NSObject+YLT_Extension.h"
#import <sys/types.h>
#import <sys/sysctl.h>
#import <objc/message.h>
#import "YLT_BaseMacro.h"
#import <MJExtension/MJExtension.h>
#import <FastCoding/FastCoder.h>

@interface XXObserverRemover : NSObject {
    __strong NSMutableArray *_centers;
    __unsafe_unretained id _obs;
}
@end
@implementation XXObserverRemover

- (instancetype)initWithObserver:(id)obs {
    if (self = [super init]) {
        _obs = obs;
        _centers = @[].mutableCopy;
    }
    return self;
}

- (void)addCenter:(NSNotificationCenter*)center {
    if (center && ![_centers containsObject:center]) {
        [_centers addObject:center];
    }
}

- (void)dealloc {
    @autoreleasepool {
        for (NSNotificationCenter *center in _centers) {
            [center removeObserver:_obs];
        }
    }
}

@end

void addCenterForObserver(NSNotificationCenter *center ,id obs) {
    XXObserverRemover *remover = nil;
    static char removerKey;
    @autoreleasepool {
        remover = objc_getAssociatedObject(obs, &removerKey);
        if (!remover) {
            remover = [[XXObserverRemover alloc] initWithObserver:obs];
            objc_setAssociatedObject(obs, &removerKey, remover, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        [remover addCenter:center];
    }
}

void ylt_swizzleClassMethod(Class cls, SEL originSelector, SEL newSelector) {
    Method originalMethod = class_getClassMethod(cls, originSelector);
    Method swizzledMethod = class_getClassMethod(cls, newSelector);
    Class metacls = objc_getMetaClass(NSStringFromClass(cls).UTF8String);
    if (class_addMethod(metacls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(metacls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

void ylt_swizzleInstanceMethod(Class cls, SEL originSelector, SEL newSelector) {
    Method originalMethod = class_getInstanceMethod(cls, originSelector);
    Method swizzledMethod = class_getInstanceMethod(cls, newSelector);
    if (class_addMethod(cls,
                        originSelector,
                        method_getImplementation(swizzledMethod),
                        method_getTypeEncoding(swizzledMethod)) ) {
        class_replaceMethod(cls,
                            newSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
        
    } else {
        class_replaceMethod(cls,
                            newSelector,
                            class_replaceMethod(cls,
                                                originSelector,
                                                method_getImplementation(swizzledMethod),
                                                method_getTypeEncoding(swizzledMethod)),
                            method_getTypeEncoding(originalMethod));
    }
}

@implementation NSObject (YLT_Extension)

@dynamic ylt_semaphore;
@dynamic ylt_semaphoreBlock;

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [NSNotificationCenter ylt_swizzleInstanceMethod:@selector(addObserver:selector:name:object:) withMethod:@selector(ylt_addObserver:selector:name:object:)];
    });
}

- (void)ylt_addObserver:(id)observer selector:(SEL)aSelector name:(nullable NSNotificationName)aName object:(nullable id)anObject{
    [self ylt_addObserver:observer selector:aSelector name:aName object:anObject];
    if ([observer isKindOfClass:[UIViewController class]] || [observer isKindOfClass:[UIView class]]) {
        addCenterForObserver(self, observer);
    }
}

/**
 获取当前的控制器
 
 @return 当前控制器
 */
- (UIViewController *)ylt_currentVC {
    UIResponder *responder = nil;
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(window in windows) {
            if (window.windowLevel == UIWindowLevelNormal) {
                break;
            }
        }
    }
    for (UIView *subView in [window subviews]) {
        responder = [subView nextResponder];
        if ([responder isEqual:window]) {
            if ([[subView subviews] count]) {
                UIView *subSubView = [subView subviews][0];
                responder = [subSubView nextResponder];
            }
        }
        
    }
    if (responder == nil || ![responder isKindOfClass:[UIViewController class]]) {
        responder = window.rootViewController;
    }
    return [self ylt_topViewController:((UIViewController *) responder)];
}

- (UIViewController *)ylt_topViewController:(UIViewController *)controller {
    BOOL isPresenting = NO;
    do {
        UIViewController *presented = [controller presentedViewController];
        isPresenting = presented != nil;
        if(presented != nil) {
            controller = presented;
        }
    } while (isPresenting);
    while ([controller isKindOfClass:[UITabBarController class]]) {
        controller = ((UITabBarController *) controller).selectedViewController;
        if ([controller isKindOfClass:[UINavigationController class]]) {
            controller = [((UINavigationController *) controller).viewControllers lastObject];
        }
    }
    if ([controller isKindOfClass:[UINavigationController class]]) {
        controller = [((UINavigationController *) controller).viewControllers lastObject];
    }
    return controller;
}

/**
 方法交换 类方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)ylt_swizzleClassMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    ylt_swizzleClassMethod([self class], origSelector, newSelector);
}

/**
 方法交换 实例方法
 
 @param origSelector 原始方法
 @param newSelector 替换的方法
 */
+ (void)ylt_swizzleInstanceMethod:(SEL)origSelector withMethod:(SEL)newSelector {
    ylt_swizzleInstanceMethod(self, origSelector, newSelector);
}

/**
 *  存储对象
 *
 *  @param key key
 */
- (void)ylt_storeValueWithKey:(NSString *)key {
    NSParameterAssert(self);
    NSParameterAssert(key);
    
    NSData *data = [FastCoder dataWithRootObject:self];
    if (data) {
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}

/**
 *  获取对象
 *
 *  @param key key
 *
 *  @return 对象
 */
+ (id)ylt_valueByKey:(NSString *)key {
    NSParameterAssert(key);
    if (![[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
        return nil;
    }
    NSData *data = [[NSUserDefaults standardUserDefaults] valueForKey:key];
    return [FastCoder objectWithData:data];
}

/**
 *  移除对象
 *
 *  @param key key
 */
+ (void)ylt_removeValueForKey:(NSString *)key {
    NSParameterAssert(key);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    YLT_LogWarn(@"设置的值VALUE:%@ 没有对应的KEY:%@", value, key);
}

#pragma mark -

- (dispatch_semaphore_t)ylt_semaphore {
    dispatch_semaphore_t result = objc_getAssociatedObject(self, @selector(ylt_semaphore));
    if (!result) {
        result = dispatch_semaphore_create(1);
        objc_setAssociatedObject(self, @selector(ylt_semaphore), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

- (dispatch_semaphore_t)ylt_semaphoreBlock {
    dispatch_semaphore_t result = objc_getAssociatedObject(self, @selector(ylt_semaphoreBlock));
    if (!result) {
        result = dispatch_semaphore_create(0);
        objc_setAssociatedObject(self, @selector(ylt_semaphoreBlock), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

- (void)setYlt_isSelected:(BOOL)ylt_isSelected {
    objc_setAssociatedObject(self, @selector(ylt_isSelected), @(ylt_isSelected), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ylt_isSelected {
    return [objc_getAssociatedObject(self, @selector(ylt_isSelected)) boolValue];
}

- (void)setYlt_isLast:(BOOL)ylt_isLast {
    objc_setAssociatedObject(self, @selector(ylt_isLast), @(ylt_isLast), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)ylt_isLast {
    return [objc_getAssociatedObject(self, @selector(ylt_isLast)) boolValue];
}

- (void)setYlt_isFirst:(BOOL)ylt_isFirst {
    objc_setAssociatedObject(self, @selector(ylt_isFirst), @(ylt_isFirst), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isFirst {
    return [objc_getAssociatedObject(self, @selector(ylt_isFirst)) boolValue];
}

@end
