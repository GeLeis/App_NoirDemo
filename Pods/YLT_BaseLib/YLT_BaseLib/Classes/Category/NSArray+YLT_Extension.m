//
//  NSArray+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by Alex on 2020/2/8.
//

#import "NSArray+YLT_Extension.h"
#import "NSObject+YLT_Extension.h"

@implementation NSArray (YLT_Extension)
@dynamic ylt_selectedObject;

- (id)ylt_selectedObject {
    if (self.ylt_selectedIndex == -1) {
        return nil;
    }
    return self[self.ylt_selectedIndex];
}

- (void)setYlt_selectedIndex:(NSInteger)ylt_selectedIndex {
    if (ylt_selectedIndex == -1) {
        objc_setAssociatedObject(self, @selector(ylt_selectedIndex), nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        return;
    }
    NSObject *obj = [self objectAtIndex:ylt_selectedIndex];
    if ([obj isKindOfClass:NSObject.class]) {
        obj.ylt_isSelected = YES;
    }
    objc_setAssociatedObject(self, @selector(ylt_selectedIndex), @(ylt_selectedIndex), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSInteger)ylt_selectedIndex {
    id obj = objc_getAssociatedObject(self, @selector(ylt_selectedIndex));
    if (obj == nil) {
        return -1;
    }
    NSInteger result = [obj integerValue];
    if (result < 0) {
        result = 0;
    }
    if (result > self.count-1) {
        result = self.count-1;
    }
    return result;
}

@end
