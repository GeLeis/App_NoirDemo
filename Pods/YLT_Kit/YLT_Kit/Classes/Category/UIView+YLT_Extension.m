//
//  UIView+YLT_Extension.m
//  AFNetworking
//
//  Created by 项普华 on 2018/4/13.
//

#import "UIView+YLT_Extension.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation UIView (YLT_Extension)

/**
 view的标识
 */
+ (NSString *)ylt_identify {
    return NSStringFromClass(self);
}

- (void)ylt_shakeAnimation {
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position.x";
    animation.values = @[ @0, @10, @-10, @10, @0 ];
    animation.keyTimes = @[ @0, @(1 / 6.0), @(3 / 6.0), @(5 / 6.0), @1 ];
    animation.duration = 0.5;
    animation.additive = YES;
    [self.layer addAnimation:animation forKey:@"shake"];
}

- (void)ylt_jitterAnimation {
    CAKeyframeAnimation *animationY = [CAKeyframeAnimation animation];
    animationY.keyPath = @"position.y";
    animationY.values = @[ @0, @5, @-5, @5, @0 ];
    animationY.keyTimes = @[ @0, @0.1, @0.3, @0.5, @1 ];
    animationY.duration = 0.5;
    animationY.additive = YES;
    [self.layer addAnimation:animationY forKey:@"shake"];
}

- (void)ylt_scaleAnimation {
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    self.layer.anchorPoint = CGPointMake(.5,.5);
    animation.fromValue = @0.9f;
    animation.toValue = @1.10f;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = YES;
    [animation setAutoreverses:NO];
    animation.duration = 0.3;
    [self.layer addAnimation:animation forKey:@"scale"];
}

- (void)ylt_clickableAfter:(NSTimeInterval)second {
    self.userInteractionEnabled = NO;
    NSTimeInterval delayInSeconds = second;
    dispatch_time_t delayInNanoSeconds = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
    dispatch_queue_t concurrentQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_after(delayInNanoSeconds, concurrentQueue, ^(void){
        YLT_MAIN(^{
            self.userInteractionEnabled = YES;
        });
    });
}

- (CAGradientLayer *)ylt_gradientLayerWithColors:(NSArray *)cgColorArray
                                       locations:(NSArray *)floatNumArray
                                      startPoint:(CGPoint )startPoint
                                        endPoint:(CGPoint)endPoint{
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.frame = self.bounds;
    if (cgColorArray && [cgColorArray count] > 0) {
        layer.colors = cgColorArray;
    } else {
        return nil;
    }
    if (floatNumArray && [floatNumArray count] == [cgColorArray count]) {
        layer.locations = floatNumArray;
    }
    layer.startPoint = startPoint;
    layer.endPoint = endPoint;
    [self.layer insertSublayer:layer atIndex:0];
    
    return layer;
}

/**
 部分角生成圆角
 
 @param rectCorner 指定角
 @param radius 圆角率
 */
- (void)ylt_cornerType:(UIRectCorner)rectCorner radius:(NSUInteger)radius {
    YLT_MAINDelay(0.1, ^{
        //绘制圆角 要设置的圆角 使用“|”来组合
        UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:rectCorner cornerRadii:CGSizeMake(radius, radius)];
        CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
        //设置大小
        maskLayer.frame = self.bounds;
        //设置图形样子
        maskLayer.path = maskPath.CGPath;
        self.layer.mask = maskLayer;
    });
}

- (void)ylt_borderWidth:(CGFloat)width
           cornerRadius:(CGFloat)radius
            borderColor:(UIColor *)color{
    
    [self.layer setMasksToBounds:true];
    [self.layer setCornerRadius:radius];
    [self.layer setBorderColor:color.CGColor];
    [self.layer setBorderWidth:width];
}

- (void)ylt_shadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity {
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    self.clipsToBounds = NO;
}

@end
