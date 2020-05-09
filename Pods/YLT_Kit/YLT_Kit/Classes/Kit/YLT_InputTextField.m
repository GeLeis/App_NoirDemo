//
//  YLT_InputTextField.m
//  TestView
//
//  Created by 项普华 on 2018/12/10.
//  Copyright © 2018 项普华. All rights reserved.
//

#import "YLT_InputTextField.h"

@interface YLT_InputTextField ()<UITextFieldDelegate> {
}
@end

@implementation YLT_InputTextField

- (instancetype)init {
    self = [super init];
    if (self) {
        [self lineView];
        [self inputTextfield];
        [self placeholderLabel];
        RAC(self.lineView, backgroundColor) = RACObserve(self, mainColor);
        RAC(self.placeholderLabel, textColor) = RACObserve(self, normalColor);
        RAC(self.inputTextfield, textColor) = RACObserve(self, mainColor);
    }
    return self;
}

/**
 设置输入框中的内容
 
 @param text 文字内容
 @param animated 是否需要动画
 */
- (void)inputText:(NSString *)text withAnimated:(BOOL)animated {
    self.inputTextfield.text = text;
    [self show:text.length!=0 animated:animated];
}

- (void)dismissWithAnimated:(BOOL)animated {
    if (self.inputTextfield.text.length == 0) {//为零的时候才需要隐藏动画
        [self show:NO animated:animated];
    }
    self.lineView.backgroundColor = self.mainColor;
}

- (void)show:(BOOL)show animated:(BOOL)animated {
    if (show) {
        [self.placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputTextfield);
            make.bottom.equalTo(self.inputTextfield.mas_top);
        }];
        self.lineView.backgroundColor = self.tintColor;
    } else {
        [self.placeholderLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputTextfield);
            make.centerY.equalTo(self.inputTextfield);
        }];
        self.lineView.backgroundColor = self.mainColor;
    }
    if (animated) {
        [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
            self.placeholderLabel.transform = show ? CGAffineTransformTranslate(CGAffineTransformMakeScale(0.75, 0.75), -self.placeholderLabel.ylt_width*0.125, 0) : CGAffineTransformIdentity;
            [self layoutIfNeeded];
        } completion:^(BOOL finished) {
        }];
    } else {
        self.placeholderLabel.transform = show ? CGAffineTransformTranslate(CGAffineTransformMakeScale(0.75, 0.75), -self.placeholderLabel.ylt_width*0.125, 0) : CGAffineTransformIdentity;
        [self layoutIfNeeded];
    }
}

- (UILabel *)placeholderLabel {
    if (!_placeholderLabel) {
        _placeholderLabel = UILabel.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.left.equalTo(self.inputTextfield);
            make.centerY.equalTo(self.inputTextfield);
        }).ylt_convertToLabel().ylt_fontSize(14).ylt_textColor(@"999999".ylt_colorFromHexString);
    }
    return _placeholderLabel;
}

- (UITextField *)inputTextfield {
    if (!_inputTextfield) {
        _inputTextfield = UITextField.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.top.mas_equalTo(24);
            make.bottom.equalTo(self);
            make.left.equalTo(self).offset(16);
            make.right.equalTo(self).offset(-16);
        }).ylt_convertToTextField().ylt_font([UIFont systemFontOfSize:14]).ylt_textColor(@"333333".ylt_colorFromHexString);
        _inputTextfield.clearButtonMode = UITextFieldViewModeWhileEditing;
        @weakify(self);
        [[self.inputTextfield rac_signalForControlEvents:UIControlEventEditingDidBegin] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self show:YES animated:YES];
        }];
        [[_inputTextfield rac_signalForControlEvents:UIControlEventEditingDidEnd] subscribeNext:^(__kindof UIControl * _Nullable x) {
            @strongify(self);
            [self dismissWithAnimated:YES];
        }];
        [_inputTextfield.rac_textSignal subscribeNext:^(NSString * _Nullable x) {
            @strongify(self);
            if (self.inputTextChange) {
                self.inputTextChange(x);
            }
        }];
    }
    return _inputTextfield;
}

- (UIImageView *)lineView {
    if (!_lineView) {
        _lineView = UIImageView.ylt_createLayout(self, ^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.inputTextfield);
            make.height.mas_equalTo(0.5);
        }).ylt_backgroundColor(@"333333".ylt_colorFromHexString).ylt_convertToImageView();
    }
    return _lineView;
}

- (UIColor *)normalColor {
    if (!_normalColor) {
        _normalColor = @"999999".ylt_colorFromHexString;
    }
    return _normalColor;
}

- (UIColor *)mainColor {
    if (!_mainColor) {
        _mainColor = @"333333".ylt_colorFromHexString;
    }
    return _mainColor;
}

- (UIColor *)tintColor {
    if (!_tintColor) {
        _tintColor = @"FF0000".ylt_colorFromHexString;
    }
    return _tintColor;
}

@end
