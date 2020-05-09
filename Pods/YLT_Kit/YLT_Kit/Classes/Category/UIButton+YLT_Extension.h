//
//  UIButton+YLT_Extension.h
//  AFNetworking
//
//  Created by 项普华 on 2018/4/13.
//

#import <UIKit/UIKit.h>

@interface UIButton (YLT_Extension)

/**
 同时赋值按钮的初始图片、高亮图片
 
 @param image 初始图片
 @param imageHL 高亮图片
 */
- (void)ylt_setImage:(UIImage *)image imageHL:(UIImage *)imageHL;

@end
