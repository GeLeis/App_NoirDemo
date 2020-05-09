//
//  UILabel+YLT_Create.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UILabel+YLT_Create.h"
#import "UIView+YLT_Create.h"
#import <objc/runtime.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UILabel (YLT_Create)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return (action == @selector(copyText:));
}

- (void)attachTapHandler {
    self.userInteractionEnabled = YES;
    UILongPressGestureRecognizer *g = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)];
    [self addGestureRecognizer:g];
}

//  手势事件
- (void)handleTap:(UIGestureRecognizer *)g {
    if ([self isFirstResponder]) {
        return;
    }
    [self becomeFirstResponder];
    
    UIMenuItem *item = [[UIMenuItem alloc] initWithTitle:@"复制" action:@selector(copyText:)];
    [[UIMenuController sharedMenuController] setMenuItems:[NSArray arrayWithObject:item]];
    [[UIMenuController sharedMenuController] setTargetRect:self.frame inView:self.superview];
    [[UIMenuController sharedMenuController] setMenuVisible:YES animated:YES];
}

//  复制时执行的方法
- (void)copyText:(id)sender {
    UIPasteboard *pBoard = [UIPasteboard generalPasteboard];
    if (objc_getAssociatedObject(self, @"expectedText")) {
        pBoard.string = objc_getAssociatedObject(self, @"expectedText");
    } else {
        if (self.text) {
            pBoard.string = self.text;
        } else {
            pBoard.string = self.attributedText.string;
        }
    }
}

- (BOOL)canBecomeFirstResponder {
    return [objc_getAssociatedObject(self, @selector(ylt_isCopyable)) boolValue];
}

- (void)setYlt_isCopyable:(BOOL)ylt_isCopyable {
    objc_setAssociatedObject(self, @selector(ylt_isCopyable), [NSNumber numberWithBool:ylt_isCopyable], OBJC_ASSOCIATION_ASSIGN);
    [self attachTapHandler];
}

- (BOOL)ylt_isCopyable {
    return [objc_getAssociatedObject(self, @selector(ylt_isCopyable)) boolValue];
}


/**
 文字
 */
- (UILabel *(^)(id text))ylt_text {
    @weakify(self);
    return ^id(id text) {
        @strongify(self);
        if ([text isKindOfClass:NSString.class]) {
            self.text = text;
        } else if ([text isKindOfClass:RACSignal.class]) {
            [((RACSignal *) text) subscribeNext:^(id  _Nullable x) {
                @strongify(self);
                self.ylt_text(x);
            }];
        }
        
        return self;
    };
}
/**
 文字颜色
 */
- (UILabel *(^)(UIColor *textColor))ylt_textColor {
    @weakify(self);
    return ^id(UIColor *textColor) {
        @strongify(self);
        self.textColor = textColor;
        return self;
    };
}
/**
 字体
 */
- (UILabel *(^)(UIFont *font))ylt_font {
    @weakify(self);
    return ^id(UIFont *font) {
        @strongify(self);
        self.font = font;
        return self;
    };
}
/**
 设置字号大小
 */
- (UILabel *(^)(CGFloat fontSize))ylt_fontSize {
    @weakify(self);
    return ^id(CGFloat fontSize) {
        @strongify(self);
        self.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}

/**
 文字的对齐方式 默认左对齐
 */
- (UILabel *(^)(NSTextAlignment alignment))ylt_textAlignment {
    @weakify(self);
    return ^id(NSTextAlignment alignment) {
        @strongify(self);
        self.textAlignment = alignment;
        return self;
    };
}
/**
 文字的行数 默认为1
 */
- (UILabel *(^)(NSUInteger lineNum))ylt_lineNum {
    @weakify(self);
    return ^id(NSUInteger lineNum) {
        @strongify(self);
        self.numberOfLines = lineNum;
        return self;
    };
}
/**
 文字截取形式
 */
- (UILabel *(^)(NSLineBreakMode lineBreakMode))ylt_lineBreakMode {
    @weakify(self);
    return ^id(NSLineBreakMode lineBreakMode) {
        @strongify(self);
        self.lineBreakMode = lineBreakMode;
        return self;
    };
}

/**
 信号量
 */
- (UILabel *(^)(RACSignal *signal))ylt_signal {
    @weakify(self);
    return ^id(RACSignal *signal) {
        [signal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            if ([x isKindOfClass:[NSString class]]) {
                self.text = x;
            } else if ([x isKindOfClass:[NSNumber class]]) {
                self.text = [NSString stringWithFormat:@"%@", x];
            } else {
                self.text = [NSString stringWithFormat:@"%@", x];
            }
        }];
        return self;
    };
}

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
                       fontSize:(CGFloat)fontSize {
    UILabel *result = UILabel
    .ylt_createLayout(superView, layout)
    .ylt_convertToLabel()
    .ylt_textColor(textColor)
    .ylt_fontSize(fontSize)
    .ylt_text(text);
    return result;
}


@end
