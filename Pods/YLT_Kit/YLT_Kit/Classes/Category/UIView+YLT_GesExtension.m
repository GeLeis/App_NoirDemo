//
//  UIView+YLT_GesExtension.m
//  Gesonry
//
//  Created by 項普華 on 2017/5/30.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import "UIView+YLT_GesExtension.h"
#import <objc/message.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIView (YLT_GesExtension)

- (id(^)(id,SEL))ylt_add:(Class)cls {
    @weakify(self);
    return ^(id target,SEL action) {
        @strongify(self);
        id gesture = [[cls alloc] initWithTarget:target action:action];
        [self addGestureRecognizer:gesture];
        self.userInteractionEnabled = YES;
        return gesture;
    };
}

- (void (^)(id))ylt_remove {
    @weakify(self);
    return ^(id obj) {
        @strongify(self);
        if ([obj isKindOfClass:[UIGestureRecognizer class]]) {
            //通过实例移除手势
            [self removeGestureRecognizer:obj];
        }else {
            //通过Class类型移除手势
            for (id ges in self.gestureRecognizers) {
                if ([ges isKindOfClass:obj]) {
                    [self removeGestureRecognizer:ges];
                }
            }
        }
    };
}

- (void (^)(void))ylt_removeAll {
    @weakify(self);
    return ^() {
        @strongify(self);
        for (UIGestureRecognizer *ges in self.gestureRecognizers) {
            [self removeGestureRecognizer:ges];
        }
    };
}

- (UITapGestureRecognizer *(^)(id, SEL))ylt_tap {
    return [self ylt_add:[UITapGestureRecognizer class]];
}

- (UIPinchGestureRecognizer *(^)(id, SEL))ylt_pinch {
    return [self ylt_add:[UIPinchGestureRecognizer class]];
}

- (UIPanGestureRecognizer *(^)(id, SEL))ylt_pan {
    return [self ylt_add:[UIPanGestureRecognizer class]];
}

- (UISwipeGestureRecognizer *(^)(id, SEL))ylt_swipe {
    return [self ylt_add:[UISwipeGestureRecognizer class]];
}

- (UIRotationGestureRecognizer *(^)(id, SEL))ylt_rotation {
    return [self ylt_add:[UIRotationGestureRecognizer class]];
}

- (UILongPressGestureRecognizer *(^)(id, SEL))ylt_longPress {
    return [self ylt_add:[UILongPressGestureRecognizer class]];
}

- (void)setHitsEdgeInsets:(UIEdgeInsets)hitsEdgeInsets {
    NSValue *value = [NSValue value:&hitsEdgeInsets withObjCType:@encode(UIEdgeInsets)];
    objc_setAssociatedObject(self, @selector(hitsEdgeInsets), value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)hitsEdgeInsets {
    NSValue *value = objc_getAssociatedObject(self, @selector(hitsEdgeInsets));
    if (value) {
        UIEdgeInsets edgeInsets;
        [value getValue:&edgeInsets];
        return edgeInsets;
    } else {
        return UIEdgeInsetsZero;
    }
}

- (BOOL)pointInside:(CGPoint)point withEvent:(UIEvent *)event {
    if (self.alpha < 0.05 || !self.userInteractionEnabled || self.hidden) {
        return NO;
    }
    BOOL result = NO;
    if (UIEdgeInsetsEqualToEdgeInsets(self.hitsEdgeInsets, UIEdgeInsetsZero)) {
        result = CGRectContainsPoint(self.bounds, point);
    } else {
        result = CGRectContainsPoint(UIEdgeInsetsInsetRect(self.bounds, self.hitsEdgeInsets), point);
    }
    return result;
}

//扩展热区
- (void)ylt_enlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right {
    self.hitsEdgeInsets = UIEdgeInsetsMake(-top, -left, -bottom, -right);
}

@end
