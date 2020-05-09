//
//  UITextField+YLT_Create.m
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UITextField+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjc.h>

@implementation UITextField (YLT_Create)

/**
 文本框的类型
 */
- (UITextField *(^)(UITextBorderStyle style))ylt_textBorderStyle {
    @weakify(self);
    return ^id(UITextBorderStyle style) {
        @strongify(self);
        self.borderStyle = style;
        return self;
    };
}
/**
 文本框的占位文字
 */
- (UITextField *(^)(NSString *placeholder))ylt_placeholder {
    @weakify(self);
    return ^id(NSString *placeholder) {
        @strongify(self);
        self.placeholder = placeholder;
        return self;
    };
}
/**
 是否密文显示
 */
- (UITextField *(^)(BOOL secure))ylt_secure {
    @weakify(self);
    return ^id(BOOL secure) {
        @strongify(self);
        self.secureTextEntry = secure;
        return self;
    };
}
/**
 左边视图
 */
- (UITextField *(^)(UIView *leftView))ylt_leftView {
    @weakify(self);
    return ^id(UIView *leftView) {
        @strongify(self);
        if (CGRectEqualToRect(leftView.frame, CGRectZero)) {
            leftView.frame = CGRectMake(0, 0, 44, 44);
        }
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
        return self;
    };
}
/**
 文本框内文本的颜色
 */
- (UITextField *(^)(UIColor *textColor))ylt_textColor {
    @weakify(self);
    return ^id(UIColor *textColor) {
        @strongify(self);
        self.textColor = textColor;
        return self;
    };
}

/**
 文本框字体颜色
 */
- (UITextField *(^)(UIFont *font))ylt_font {
    @weakify(self);
    return  ^id(UIFont *font) {
        @strongify(self);
        self.font = font;
        return self;
    };
}
/**
 键盘类型
 */
- (UITextField *(^)(UIKeyboardType keyboardType))ylt_keyboardType {
    @weakify(self);
    return ^id (UIKeyboardType keyboardType) {
        @strongify(self);
        self.keyboardType = keyboardType;
        return self;
    };
}

/**
 return type
 */
- (UITextField *(^)(UIReturnKeyType returnKeyType))ylt_returnKeyType {
    @weakify(self);
    return ^id(UIReturnKeyType returnKeyType) {
        @strongify(self);
        self.returnKeyType = returnKeyType;
        return self;
    };
}

/**
 文本框内容发生改变时的调用
 */
- (UITextField *(^)(void(^textDidChange)(NSString *value)))ylt_textDidChange {
    @weakify(self);
    return ^id(void(^textDidChange)(NSString *value)) {
        @strongify(self);
        [self.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            if (textDidChange) {
                textDidChange(x);
            }
        }];
        return self;
    };
}

/**
 过滤类型
 */
- (UITextField *(^)(YLT_StringFilterType filterType))ylt_filterType {
    @weakify(self);
    return ^id(YLT_StringFilterType filterType) {
        @strongify(self);
        return self;
    };
}

/**
 限制长度
 */
- (UITextField *(^)(NSUInteger limitLength))ylt_limitLength {
    @weakify(self);
    return ^id(NSUInteger limitLength) {
        @strongify(self);
        [self.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            
        }];
        return self;
    };
}

/**
 信号量
 */
- (UITextField *(^)(RACSignal *signal))ylt_signal {
    @weakify(self);
    return ^id(RACSignal *signal) {
        [signal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.text = [NSString stringWithFormat:@"%@", x];
        }];
        return self;
    };
}

@end
