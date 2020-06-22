//
//  NSDictionary+GLSafe.m
//  TableViewDemo
//
//  Created by gelei on 2020/6/22.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "NSDictionary+GLSafe.h"
#import "GLSafeTool.h"

@implementation NSDictionary (GLSafe)

- (instancetype)glsf_initWithObjects:(id  _Nonnull const [])objects forKeys:(id<NSCopying>  _Nonnull const [])keys count:(NSUInteger)cnt {
    NSUInteger newCnt = 0;
    for (NSUInteger i = 0; i < cnt; i++) {
        if (!(keys[i] && objects[i])) {
            break;
        }
        newCnt++;
    }
    return [self glsf_initWithObjects:objects forKeys:keys count:newCnt];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSPlaceholderDictionary"), @selector(initWithObjects:forKeys:count:), @selector(glsf_initWithObjects:forKeys:count:));
    });
}

@end
