//
//  UITextField+YLT_Create.h
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, YLT_StringFilterType) {
    YLT_STRING_FILTER_TYPE_NUMBER = 100,//纯数字
    YLT_STRING_FILTER_TYPE_LETTER,//纯字母
    YLT_STRING_FILTER_TYPE_HANZI,//汉字
    YLT_STRING_FILTER_TYPE_EMOJI,//emoji
    YLT_STRING_FILTER_TYPE_SYMBOL,//符号
    YLT_STRING_FILTER_TYPE_NONE,//没有限制
};

@interface UITextField (YLT_Create)

/**
 文本框的类型
 */
- (UITextField *(^)(UITextBorderStyle style))ylt_textBorderStyle;
/**
 文本框的占位文字
 */
- (UITextField *(^)(NSString *placeholder))ylt_placeholder;
/**
 是否密文显示
 */
- (UITextField *(^)(BOOL secure))ylt_secure;
/**
 文本框内文本的颜色
 */
- (UITextField *(^)(UIColor *textColor))ylt_textColor;
/**
 文本框字体颜色
 */
- (UITextField *(^)(UIFont *font))ylt_font;
/**
 左边视图
 */
- (UITextField *(^)(UIView *leftView))ylt_leftView;
/**
 键盘类型
 */
- (UITextField *(^)(UIKeyboardType keyboardType))ylt_keyboardType;

/**
 return type
 */
- (UITextField *(^)(UIReturnKeyType returnKeyType))ylt_returnKeyType;

/**
 文本框内容发生改变时的调用
 */
- (UITextField *(^)(void(^textDidChange)(NSString *value)))ylt_textDidChange;
/**
 过滤类型
 */
- (UITextField *(^)(YLT_StringFilterType filterType))ylt_filterType;
/**
 限制长度
 */
- (UITextField *(^)(NSUInteger limitLength))ylt_limitLength;

@end
