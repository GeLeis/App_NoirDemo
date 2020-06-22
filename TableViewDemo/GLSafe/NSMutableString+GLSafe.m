//
//  NSMutableString+GLSafe.m
//  TableViewDemo
//
//  Created by gelei on 2020/6/22.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "NSMutableString+GLSafe.h"
#import "GLSafeTool.h"

@implementation NSMutableString (GLSafe)

- (void)glsf_appendString:(NSString *)aString {
    if (!aString) {
        return;
    }
    [self glsf_appendString:aString];
}

- (void)glsf_appendFormat:(NSString *)format, ... {
    if (!format) {
        return;
    }
    va_list arguments;
    va_start(arguments, format);
    NSString *formatStr = [[NSString alloc] initWithFormat:format arguments:arguments];
    [self glsf_appendFormat:@"%@",formatStr];
    va_end(arguments);
}

- (void)glsf_setString:(NSString *)aString {
    if (!aString) {
        return;
    }
    [self glsf_setString:aString];
}

- (void)glsf_insertString:(NSString *)aString atIndex:(NSUInteger)loc {
    if (loc > self.length) {
        return;
    }
    if (!aString) {
        return;
    }
}

- (void)glsf_deleteCharactersInRange:(NSRange)range {
    if (range.location + range.length > self.length) {
        return;
    }
    [self glsf_deleteCharactersInRange:range];
}

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(appendString:), @selector(glsf_appendString:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(appendFormat:), @selector(glsf_appendFormat:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(setString:), @selector(glsf_setString:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(insertString:atIndex:), @selector(glsf_insertString:atIndex:));
        glsf_swizzleInstanceMethod(NSClassFromString(@"__NSCFString"), @selector(deleteCharactersInRange:), @selector(glsf_deleteCharactersInRange:));
    });
}
@end
