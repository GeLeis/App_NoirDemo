//
//  UIView+YLT_GesExtension.h
//  Gesonry
//
//  Created by 項普華 on 2017/5/30.
//  Copyright © 2017年 項普華. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  添加手势封装
 *  使用方法ylt_手势类型(target,SEL)
 *  内部自动设置userInteractionEnabled = YES
 */
@interface UIView (YLT_GesExtension)

/**
 设置视图的触摸范围 （主要用来扩大视图的触摸区域）
 */
@property (nonatomic, assign) UIEdgeInsets hitsEdgeInsets;

/**
 *  添加点按手势
 */
- (UITapGestureRecognizer *(^)(id, SEL))ylt_tap;
/**
 *  添加拖动手势
 */
- (UIPanGestureRecognizer *(^)(id, SEL))ylt_pan;
/**
 *  添加捏合手势
 */
- (UIPinchGestureRecognizer *(^)(id, SEL))ylt_pinch;
/**
 *  添加旋转手势
 */
- (UIRotationGestureRecognizer *(^)(id, SEL))ylt_rotation;
/**
 *  添加长按手势
 */
- (UILongPressGestureRecognizer *(^)(id, SEL))ylt_longPress;
/**
 *  添加轻扫手势
 */
- (UISwipeGestureRecognizer *(^)(id, SEL))ylt_swipe;

/**
 *  添加手势
 *
 *  @param cls 系统自带或者自定义手势Class
 */
- (id(^)(id, SEL))ylt_add:(Class)cls;

/**
 *  移除手势，参数可以是手势实例对象或者手势Class
 */
- (void(^)(id))ylt_remove;

/**
 *  移除所有已添加的手势
 */
- (void (^)(void))ylt_removeAll;

//扩展热区
- (void)ylt_enlargeEdgeWithTop:(CGFloat)top left:(CGFloat)left bottom:(CGFloat)bottom right:(CGFloat)right;

@end
