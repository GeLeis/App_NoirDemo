//
//  YLT_InputTextField.h
//  TestView
//
//  Created by 项普华 on 2018/12/10.
//  Copyright © 2018 项普华. All rights reserved.
//

#import <YLT_Kit/YLT_Kit.h>

@interface YLT_InputTextField : YLT_BaseView

/**
 普通颜色
 */
@property (nonatomic, strong) UIColor *normalColor;

/**
 主颜色
 */
@property (nonatomic, strong) UIColor *mainColor;

/**
 高亮色
 */
@property (nonatomic, strong) UIColor *tintColor;

/**
 placeholder label
 */
@property (nonatomic, strong) UILabel *placeholderLabel;

/**
 输入框内容
 */
@property (nonatomic, strong) UITextField *inputTextfield;

/**
 分割线
 */
@property (nonatomic, strong) UIImageView *lineView;

/**
 输入框内容变化的回调
 */
@property (nonatomic, copy) void(^inputTextChange)(NSString *sender);

/**
 设置输入框中的内容

 @param text 文字内容
 @param animated 是否需要动画
 */
- (void)inputText:(NSString *)text withAnimated:(BOOL)animated;

@end
