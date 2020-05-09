//
//  UIButton+YLT_Extension.m
//  AFNetworking
//
//  Created by 项普华 on 2018/4/13.
//

#import "UIButton+YLT_Extension.h"

@implementation UIButton (YLT_Extension)

/**
 同时赋值按钮的初始图片、高亮图片
 
 @param image 初始图片
 @param imageHL 高亮图片
 */
- (void)ylt_setImage:(UIImage *)image imageHL:(UIImage *)imageHL {
    [self setImage:image forState:UIControlStateNormal];
    [self setImage:imageHL forState:UIControlStateHighlighted];
}

@end
