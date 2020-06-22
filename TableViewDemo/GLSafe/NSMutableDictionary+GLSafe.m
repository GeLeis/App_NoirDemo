//
//  NSMutableDictionary+GLSafe.m
//  TableViewDemo
//
//  Created by gelei on 2020/6/22.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "NSMutableDictionary+GLSafe.h"
#import "GLSafeTool.h"

@implementation NSMutableDictionary (GLSafe)

- (void)glsf_setObject:(id)anObject forKey:(id<NSCopying>)aKey {
    if (!anObject) {
        return;
    }
    if (!aKey) {
        return;
    }
    [self glsf_setObject:anObject forKey:aKey];
}

- (void)glsf_setObject:(id)obj forKeyedSubscript:(id<NSCopying>)key {
    if (!obj) {
        return;
    }
    if (!key) {
        return;
    }
    [self glsf_setObject:obj forKeyedSubscript:key];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKey:), @selector(glsf_setObject:forKey:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSDictionaryM"), @selector(setObject:forKeyedSubscript:), @selector(glsf_setObject:forKeyedSubscript:));
    });
}
@end
