//
//  UILabel+YLT_Extension.m
//  BlackCard
//
//  Created by yaohuix on 2018/4/11.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "UILabel+YLT_Extension.h"
#import <CoreText/CoreText.h>

@implementation UILabel (YLT_Extension)

- (void)ylt_columnSpace:(CGFloat)columnSpace {
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    //调整间距
    [attributedString addAttribute:(__bridge NSString *)kCTKernAttributeName
                             value:@(columnSpace)
                             range:NSMakeRange(0, [attributedString length])];
    
    self.attributedText = attributedString;
}

- (void)ylt_rowSpace:(CGFloat)rowSpace {
    self.numberOfLines = 0;
    NSMutableAttributedString *attributedString =
    [[NSMutableAttributedString alloc] initWithAttributedString:self.attributedText];
    
    //调整行距
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = rowSpace;
    paragraphStyle.baseWritingDirection = NSWritingDirectionLeftToRight;
    [attributedString addAttribute:NSParagraphStyleAttributeName
                             value:paragraphStyle
                             range:NSMakeRange(0, [self.text length])];
    self.attributedText = attributedString;
}

@end

