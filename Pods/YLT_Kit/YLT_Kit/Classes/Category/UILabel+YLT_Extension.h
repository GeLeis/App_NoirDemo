//
//  UILabel+YLT_Extension.h
//  BlackCard
//
//  Created by yaohuix on 2018/4/11.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UILabel (YLT_Extension)

/**
 给label设置字间距
 
 @param columnSpace 间距的长度
 */
- (void)ylt_columnSpace:(CGFloat)columnSpace;

/**
 给label设置行间距
 
 @param rowSpace 行间距的距离
 */
- (void)ylt_rowSpace:(CGFloat)rowSpace;


@end

