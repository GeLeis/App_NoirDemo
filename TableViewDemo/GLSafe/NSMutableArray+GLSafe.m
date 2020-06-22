//
//  NSMutableArray+GLSafe.m
//  TableViewDemo
//
//  Created by gelei on 2020/6/19.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "NSMutableArray+GLSafe.h"
#import "GLSafeTool.h"

@implementation NSMutableArray (GLSafe)

- (id)glsf_objectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return nil;
    }
    return [self glsf_objectAtIndex:index];
}

- (id)glsf_objectAtIndexedSubscript:(NSUInteger)idx {
    if (idx >= self.count) {
        return nil;
    }
    return [self glsf_objectAtIndexedSubscript:idx];
}

- (void)glsf_addObject:(id)anObject {
    if (!anObject) {
        return;
    }
    [self glsf_addObject:anObject];
}

- (void)glsf_insertObject:(id)anObject atIndex:(NSUInteger)index {
    if (index > self.count) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self glsf_insertObject:anObject atIndex:index];
}

- (void)glsf_removeObjectAtIndex:(NSUInteger)index {
    if (index >= self.count) {
        return;
    }
    [self glsf_removeObjectAtIndex:index];
}

- (void)glsf_replaceObjectAtIndex:(NSUInteger)index withObject:(id)anObject {
    if (index >= self.count) {
        return;
    }
    if (!anObject) {
        return;
    }
    [self glsf_replaceObjectAtIndex:index withObject:anObject];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndexedSubscript:), @selector(glsf_objectAtIndexedSubscript:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(objectAtIndex:), @selector(glsf_objectAtIndex:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(addObject:), @selector(glsf_addObject:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(insertObject:atIndex:), @selector(glsf_insertObject:atIndex:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(removeObjectAtIndex:), @selector(glsf_removeObjectAtIndex:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSArrayM"), @selector(replaceObjectAtIndex:withObject:), @selector(glsf_replaceObjectAtIndex:withObject:));
    });
}

@end
