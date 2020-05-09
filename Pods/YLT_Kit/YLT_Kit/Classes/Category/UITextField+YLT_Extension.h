//
//  UITextField+YLT_Extension.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/21.
//

#import <UIKit/UIKit.h>

@interface UITextField (YLT_Extension)

@property(nonatomic, assign) NSRange ylt_selectedRange;

/// UITextField 输入框长度限制
- (void)textFieldDidChange:(UITextField *)textField count:(NSUInteger)count;

/// 输入金额字符串进行验证
- (BOOL)amountStringIsEnteredForValidation:(NSString *)string;

@end
