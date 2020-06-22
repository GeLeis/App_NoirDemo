//
//  NSString+GLSafe.m
//  TableViewDemo
//
//  Created by gelei on 2020/6/22.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "NSString+GLSafe.h"
#import "GLSafeTool.h"

@implementation NSString (GLSafe)

- (unichar)glsf_characterAtIndex:(NSUInteger)index {
    if (index >= self.length) {
        return 0;
    }
    return [self glsf_characterAtIndex:index];
}

- (NSString *)glsf_substringFromIndex:(NSUInteger)from {
    if (from > self.length) {
        return nil;
    }
    return [self glsf_substringFromIndex:from];
}

- (NSString *)glsf_substringWithRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        return nil;
    }
    return [self glsf_substringWithRange:range];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(characterAtIndex:), @selector(glsf_characterAtIndex:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(substringFromIndex:), @selector(glsf_substringFromIndex:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(substringWithRange:), @selector(glsf_substringWithRange:));
    });
}

@end
