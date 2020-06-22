//
//  NSNull+GLSafe.m
//  TableViewDemo
//
//  Created by gelei on 2020/6/17.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "NSNull+GLSafe.h"

#define GL_NullObjects @[@"",@0,@{},@[]]

@implementation NSNull (GLSafe)

- (NSMethodSignature *)methodSignatureForSelector:(SEL)selector {
    NSMethodSignature *signature = [super methodSignatureForSelector:selector];
    if (signature != nil) return signature;
    for (NSObject *object in GL_NullObjects) {
        signature = [object methodSignatureForSelector:selector];
        if (signature) {
            if (strcmp(signature.methodReturnType, "@") == 0) {
                signature = [[NSNull null] methodSignatureForSelector:@selector(gl_nil)];
            }
            break;
        }
    }
    
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    if (strcmp(anInvocation.methodSignature.methodReturnType, "@") == 0) {
        anInvocation.selector = @selector(gl_nil);
        [anInvocation invokeWithTarget:self];
        return;
    }
    
    for (NSObject *object in GL_NullObjects) {
        if ([object respondsToSelector:anInvocation.selector]) {
            [anInvocation invokeWithTarget:object];
            return;
        }
    }
    [self doesNotRecognizeSelector:anInvocation.selector];
}

- (id)gl_nil {
    return nil;
}
@end
