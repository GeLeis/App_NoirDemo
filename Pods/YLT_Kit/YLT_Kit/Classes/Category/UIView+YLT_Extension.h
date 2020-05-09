//
//  UIView+YLT_Extension.h
//  AFNetworking
//
//  Created by 项普华 on 2018/4/13.
//

#import <UIKit/UIKit.h>

@interface UIView (YLT_Extension)

/**
 view的标识
 */
+ (NSString *)ylt_identify;

/**
 添加闪动动画
 */
- (void)ylt_shakeAnimation;

/**
 添加抖动动画
 */
- (void)ylt_jitterAnimation;

/**
 添加放大缩小动画
 */
- (void)ylt_scaleAnimation;

/**
 在设置的时间内禁止点击view
 
 @param second 禁止点击的时间
 */
- (void)ylt_clickableAfter:(NSTimeInterval)second;

/**
 添加一个渐变层
 
 @param cgColorArray 渐变的颜色数组
 @param floatNumArray 颜色的分割点
 @param aPoint 颜色的起始位置
 @param endPoint 颜色结束位置
 @return 渐变层的对象
 */
- (CAGradientLayer *)ylt_gradientLayerWithColors:(NSArray *)cgColorArray
                                       locations:(NSArray *)floatNumArray
                                      startPoint:(CGPoint )aPoint
                                        endPoint:(CGPoint)endPoint;

/**
 部分角生成圆角

 @param rectCorner 指定角
 @param radius 圆角率
 */
- (void)ylt_cornerType:(UIRectCorner)rectCorner radius:(NSUInteger)radius;

/**
 设置内边框颜色
 
 @param width 边宽
 @param radius 半径
 @param color 色值
 */
- (void)ylt_borderWidth:(CGFloat)width
           cornerRadius:(CGFloat)radius
            borderColor:(UIColor *)color;

/**
 设置阴影
 
 @param offset 偏移量
 @param radius 阴影半径
 @param color 阴影填充颜色
 @param opacity 阴影透明度
 */
- (void)ylt_shadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;

@end
