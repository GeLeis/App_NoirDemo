//
//  UIBarButtonItem+YTL_Utils.m
//  YLT_Kit
//
//  Created by pz on 08/04/2018.
//

#import "UIBarButtonItem+YLT_Extension.h"
#import <objc/runtime.h>
#import <ReactiveObjC/ReactiveObjC.h>

NSString *const ZYBarButtonItem_hasBadgeKey = @"ZYBarButtonItem_hasBadgeKey";
NSString *const ZYBarButtonItem_badgeKey = @"ZYBarButtonItem_badgeKey";
NSString *const ZYBarButtonItem_badgeSizeKey = @"ZYBarButtonItem_badgeSizeKey";
NSString *const ZYBarButtonItem_badgeOriginXKey = @"ZYBarButtonItem_badgeOriginXKey";
NSString *const ZYBarButtonItem_badgeOriginYKey = @"ZYBarButtonItem_badgeOriginYKey";
NSString *const ZYBarButtonItem_badgeColorKey = @"ZYBarButtonItem_badgeColorKey";

@implementation UIBarButtonItem (YTL_Utils)

- (void)initBadge {
    UIView *superview = nil;
    if (self.customView) {
        superview = self.customView;
        superview.clipsToBounds = NO;
    } else if ([self respondsToSelector:@selector(view)] && [(id)self view]) {
        superview = [(id)self view];
    }
    [superview addSubview:self.badge];
    
    // 默认设置 default configure
    self.badgeColor = [UIColor redColor];
    self.badgeSize = 6;
    self.badgeOriginX = 36;
    self.badgeOriginY = 10;
    self.badge.hidden = YES;
}

- (void)showBadge {
    self.badge.hidden = NO;
}

- (void)hideBadge {
    self.badge.hidden = YES;
}

- (void)refreshBadge {
    self.badge.frame = (CGRect){self.badgeOriginX,self.badgeOriginY,self.badgeSize,self.badgeSize};
    self.badge.backgroundColor = self.badgeColor;
    self.badge.layer.cornerRadius = self.badgeSize/2;
}


#pragma mark ---------- badge getter & setter function -----------

- (UIView *)badge {
    UIView *badge = (UIView *)objc_getAssociatedObject(self, &ZYBarButtonItem_badgeKey);
    if (!badge) {
        badge = [[UIView alloc] init];
        [self setBadge:badge];
        [self initBadge];
    }
    return badge;
}

- (void)setBadge:(UIView *)badge {
    objc_setAssociatedObject(self, &ZYBarButtonItem_badgeKey, badge, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIColor *)badgeColor {
    return objc_getAssociatedObject(self, &ZYBarButtonItem_badgeColorKey);
}

- (void)setBadgeColor:(UIColor *)badgeColor {
    objc_setAssociatedObject(self, &ZYBarButtonItem_badgeColorKey, badgeColor, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(CGFloat)badgeSize {
    NSNumber *number = objc_getAssociatedObject(self, &ZYBarButtonItem_badgeSizeKey);
    return number.floatValue;
}

-(void)setBadgeSize:(CGFloat)badgeSize {
    NSNumber *number = [NSNumber numberWithDouble:badgeSize];
    objc_setAssociatedObject(self, &ZYBarButtonItem_badgeSizeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(CGFloat)badgeOriginX {
    NSNumber *number = objc_getAssociatedObject(self, &ZYBarButtonItem_badgeOriginXKey);
    return number.floatValue;
}

-(void)setBadgeOriginX:(CGFloat)badgeOriginX {
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginX];
    objc_setAssociatedObject(self, &ZYBarButtonItem_badgeOriginXKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

-(CGFloat)badgeOriginY {
    NSNumber *number = objc_getAssociatedObject(self, &ZYBarButtonItem_badgeOriginYKey);
    return number.floatValue;
}

-(void)setBadgeOriginY:(CGFloat)badgeOriginY {
    NSNumber *number = [NSNumber numberWithDouble:badgeOriginY];
    objc_setAssociatedObject(self, &ZYBarButtonItem_badgeOriginYKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    if (self.badge) {
        [self refreshBadge];
    }
}

- (void)setHasBadge:(BOOL)hasBadge {
    if (hasBadge) {
        [self showBadge];
    } else {
        [self hideBadge];
    }
    
    NSNumber *number = [NSNumber numberWithBool:hasBadge];
    objc_setAssociatedObject(self, &ZYBarButtonItem_hasBadgeKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)hasBadge {
    NSNumber *number = objc_getAssociatedObject(self, &ZYBarButtonItem_hasBadgeKey);
    return number.boolValue;
}

- (void)setYlt_clickBlock:(void (^)(UIBarButtonItem *))ylt_clickBlock {
    if (ylt_clickBlock) {
        @weakify(self);
        self.rac_command = [[RACCommand alloc] initWithSignalBlock:^RACSignal * _Nonnull(id  _Nullable input) {
            return [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
                @strongify(self);
                [subscriber sendNext:self];
                [subscriber sendCompleted];
                return nil;
            }];
        }];
        [self.rac_command.executionSignals subscribeNext:^(RACSignal<id> * _Nullable x) {
            [x subscribeNext:^(UIBarButtonItem *x) {
                if (ylt_clickBlock) {
                    ylt_clickBlock(x);
                }
            }];
        }];
    }
}

@end
