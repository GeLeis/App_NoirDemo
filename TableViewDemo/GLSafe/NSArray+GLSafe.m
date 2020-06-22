//
//  NSArray+GLSafe.m
//  TableViewDemo
//
//  Created by gelei on 2020/6/17.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "NSArray+GLSafe.h"
#import "GLSafeTool.h"

@implementation NSArray (GLSafe)

#pragma mark -- Hook

- (id)glsf_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self glsf_objectAtIndex:index];
}

- (instancetype)glsf_initWithObjects:(id  _Nonnull const [])objects count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!objects[i]) {
            break;
        }
        newCnt++;
    }
    return [self glsf_initWithObjects:objects count:newCnt];
}

- (NSArray *)glsf_subarrayWithRange:(NSRange)range {
    if (range.location >= self.count ||
        range.location + range.length > self.count) {
        return nil;
    }
    return [self subarrayWithRange:range];
}
//__NSSingleObjectArrayI、__NSArray0直接触发,@[@1],@[]
- (id)objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count) {
        return nil;
    }
    return [self objectAtIndex:idx];
}
//__NSArrayI触发
- (id)glsf_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count) {
        return nil;
    }
    return [self glsf_objectAtIndexedSubscript:idx];
}

- (NSArray *)glsf_arrayByAddingObject:(id)anObject {
    if (!anObject) {
        return self;
    }
    return [self glsf_arrayByAddingObject:anObject];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndexedSubscript:), @selector(glsf_objectAtIndexedSubscript:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(objectAtIndex:), @selector(glsf_objectAtIndex:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayI"), @selector(arrayByAddingObject:), @selector(glsf_arrayByAddingObject:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSPlaceholderArray"), @selector(initWithObjects:count:), @selector(glsf_initWithObjects:count:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSSingleObjectArrayI"), @selector(objectAtIndex:), @selector(glsf_objectAtIndex:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArray0"), @selector(objectAtIndex:), @selector(glsf_objectAtIndex:));
    });
}

@end
