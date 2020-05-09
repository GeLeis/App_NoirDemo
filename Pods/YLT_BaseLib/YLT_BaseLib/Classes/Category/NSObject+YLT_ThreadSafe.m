//
//  NSObject+YLT_ThreadSafe.m
//  YLT_BaseLib
//
//  Created by 項普華 on 2019/4/10.
//

#import "NSObject+YLT_ThreadSafe.h"
#import <objc/message.h>
#import "YLT_BaseMacro.h"
#import "NSObject+YLT_Extension.h"
#import "UIApplication+YLT_Extension.h"

#define YLT_SAFE_HOOK_SET_PRE @"ylt_propertySetThreadSafeHook_"
#define YLT_SAFE_HOOK_GET_PRE @"ylt_propertyGetThreadSafeHook_"

@interface NSObject (YLT_ThreadSafeData)

@property (nonatomic, strong, readonly) dispatch_queue_t ylt_safeQueue;

@end

@implementation NSObject (YLT_ThreadSafe)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ylt_swizzleClassMethod(self, @selector(resolveInstanceMethod:), @selector(ylt_resolveInstanceMethod:));
    });
}

+ (void)ylt_addToSafeThread {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self hookAllPropertiesSetter];
    });
}

/**
 hook类的所有属性的setter、getter 注意只读属性的处理
 */
- (void)hookAllPropertiesSetter {
    //TODO:需要忽略的属性，即不做线程安全处理的属性
    NSDictionary *ignorePropertys;
    if ([self conformsToProtocol:@protocol(YLT_ThreadSafeProtocol)]) {
        if ([self respondsToSelector:@selector(ylt_ignorePropertys)]) {
            ignorePropertys = [self performSelector:@selector(ylt_ignorePropertys)];
        }
    }
    //TODO:需要忽略的属性，即不做线程安全处理的属性
    
    unsigned int outCount;
    objc_property_t *properties = class_copyPropertyList(self.class, &outCount);
    
    NSMutableArray *readWriteProperties = [[NSMutableArray alloc] initWithCapacity:outCount];
    for (unsigned int i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        
        unsigned int attrCount;
        objc_property_attribute_t *attrs = property_copyAttributeList(property, &attrCount);
        // 抽离只读属性
        BOOL isReadOnlyProperty = NO;
        for (unsigned int j = 0; j < attrCount; j++) {
            if (attrs[j].name[0] == 'R') {
                isReadOnlyProperty = YES;
                break;
            }
        }
        free(attrs);
        
        if (!isReadOnlyProperty) {
            [readWriteProperties addObject:propertyName];
        }
    }
    free(properties);
    
    for (NSString *propertyName in readWriteProperties) {
        //HOOK SETTER
        NSString *setterName = [NSString stringWithFormat:@"set%@%@:", [propertyName substringToIndex:1].uppercaseString, [propertyName substringFromIndex:1]];
        NSString *hookSetterName = [NSString stringWithFormat:@"%@%@", YLT_SAFE_HOOK_SET_PRE, setterName];
        SEL originSetter = NSSelectorFromString(setterName);
        SEL newSetter = NSSelectorFromString(hookSetterName);
        ylt_swizzleInstanceMethod(self.class, originSetter, newSetter);
        
        //HOOK GETTER
        NSString *getterName = [NSString stringWithFormat:@"%@", propertyName];
        NSString *hookGetterName = [NSString stringWithFormat:@"%@%@", YLT_SAFE_HOOK_GET_PRE, getterName];
        SEL originGetter = NSSelectorFromString(getterName);
        SEL newGetter = NSSelectorFromString(hookGetterName);
        ylt_swizzleInstanceMethod(self.class, originGetter, newGetter);
    }
}

+ (BOOL)ylt_resolveInstanceMethod:(SEL)sel {
    NSString *selName = NSStringFromSelector(sel);
    if ([selName hasPrefix:YLT_SAFE_HOOK_SET_PRE]) {
        SEL originSel = NSSelectorFromString([selName substringFromIndex:YLT_SAFE_HOOK_SET_PRE.length]);
        Method originMethod = class_getInstanceMethod(self, originSel);
        // 通过setter方法读取属性类型
        unsigned int argCount = method_getNumberOfArguments(originMethod);
        if (argCount == 3) {// setter方法参数必定为3个 @:@  参阅：TypeEncoding
            char argName[512] = {};
            method_getArgumentType(originMethod, 2, argName, 512);
            Method proxyMethod = NULL;
            BOOL isObj = YES;
            if (strcmp(argName, @encode(NSInteger)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_NSInteger:));
            }
            if (strcmp(argName, @encode(BOOL)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_BOOL:));
            }
            if (strcmp(argName, @encode(CGFloat)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_CGFloat:));
            }
            if (strcmp(argName, @encode(NSUInteger)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_NSUInteger:));
            }
            if (strcmp(argName, @encode(char)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_char:));
            }
            if (strcmp(argName, @encode(int)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_int:));
            }
            if (strcmp(argName, @encode(float)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_float:));
            }
            if (strcmp(argName, @encode(double)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_double:));
            }
            if (strcmp(argName, @encode(Boolean)) == 0) {
                isObj = NO;
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy_Boolean:));
            }
            
            memset(argName, '\0', strlen(argName));
            if (isObj) {
                proxyMethod = class_getClassMethod(self, @selector(hook_setter_proxy:));
            }
            class_addMethod(self, sel, method_getImplementation(proxyMethod), method_getTypeEncoding(proxyMethod));
            return YES;
        }
    }
    if ([selName hasPrefix:YLT_SAFE_HOOK_GET_PRE]) {
        Method proxyMethod = class_getClassMethod(self, @selector(hook_getter_proxy));
        class_addMethod(self, sel, method_getImplementation(proxyMethod), method_getTypeEncoding(proxyMethod));
        return YES;
    }
    return [self ylt_resolveInstanceMethod:sel];
}

/**
 HOOK到所有的setter通过栅栏函数保证安全性
 */
- (void)hook_setter_proxyObject:(NSObject *)proxyObject originSelector:(NSString *)originSelector {
    if (![originSelector isKindOfClass:[NSString class]] || ![originSelector hasPrefix:@"set"] || [originSelector rangeOfString:@":"].location == NSNotFound) {
        return;
    }
    NSString *propertyName = [[originSelector stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@":"]] stringByReplacingOccurrencesOfString:@"set" withString:@""];
    if (propertyName.length <= 0) return;

    dispatch_barrier_async(self.ylt_safeQueue, ^{
        YLT_BeginIgnorePerformSelectorLeaksWarning
        if ([self respondsToSelector:_cmd]) {
            [self performSelector:_cmd withObject:proxyObject];
        }
        YLT_EndIgnorePerformSelectorLeaksWarning
    });
}

/**
 HOOK到所有的 getter 同步返回
 */
- (id)hook_getter_proxy {
    // 只是实现被换了，但是selector还是没变
    __block id result = nil;
    dispatch_sync(self.ylt_safeQueue, ^{
        YLT_BeginIgnorePerformSelectorLeaksWarning
        if ([self respondsToSelector:_cmd]) {
            result = [self performSelector:_cmd];
        }
        YLT_EndIgnorePerformSelectorLeaksWarning
    });
    return result;
}

#pragma mark - 不同参数类型的HOOK

- (void)hook_setter_proxy_int:(int)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy_NSUInteger:(NSUInteger)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy_NSInteger:(NSInteger)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy_CGFloat:(CGFloat)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy_float:(float)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy_double:(double)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy_BOOL:(BOOL)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy_Boolean:(Boolean)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy_char:(char)proxyObject {
    [self hook_setter_proxyObject:@(proxyObject) originSelector:NSStringFromSelector(_cmd)];
}

- (void)hook_setter_proxy:(NSObject *)proxyObject {
    [self hook_setter_proxyObject:proxyObject originSelector:NSStringFromSelector(_cmd)];
}

#pragma mark - setter getter

- (dispatch_queue_t)ylt_safeQueue {
    dispatch_queue_t result = objc_getAssociatedObject(self, @selector(ylt_safeQueue));
    if (result == nil) {
        result = dispatch_queue_create([NSString stringWithFormat:@"%@_thread_safe", NSStringFromClass(self.class)].UTF8String, nil);
        objc_setAssociatedObject(self, @selector(ylt_safeQueue), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

@end
