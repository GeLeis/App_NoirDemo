//
//  UILabel+YLT_Create.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface UILabel (YLT_Create)

/**
 是否可以长按复制
 */
@property (nonatomic,assign) BOOL ylt_isCopyable;
/**
 文字
 */
- (UILabel *(^)(id text))ylt_text;
/**
 文字颜色
 */
- (UILabel *(^)(UIColor *textColor))ylt_textColor;
/**
 字体
 */
- (UILabel *(^)(UIFont *font))ylt_font;
/**
 设置字号大小
 */
- (UILabel *(^)(CGFloat fontSize))ylt_fontSize;
/**
 文字的对齐方式 默认左对齐
 */
- (UILabel *(^)(NSTextAlignment alignment))ylt_textAlignment;
/**
 文字的行数 默认为1
 */
- (UILabel *(^)(NSUInteger lineNum))ylt_lineNum;
/**
 文字截取形式
 */
- (UILabel *(^)(NSLineBreakMode lineBreakMode))ylt_lineBreakMode;

#pragma mark - 快速创建对象

/**
 快速创建对象
 
 @param superView 父视图
 @param layout 布局
 @param text 文本
 @param textColor 颜色
 @param fontSize 字号
 @return 当前对象
 */
+ (UILabel *)ylt_createSuperView:(UIView *)superView
                         layout:(void(^)(MASConstraintMaker *make))layout
                           text:(NSString *)text
                          color:(UIColor *)textColor
                       fontSize:(CGFloat)fontSize;

@end
