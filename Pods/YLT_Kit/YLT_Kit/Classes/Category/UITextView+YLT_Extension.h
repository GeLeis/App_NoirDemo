//
//  UITextView+YLT_Extension.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/21.
//

#import <UIKit/UIKit.h>

@interface UITextView (YLT_Extension)

@property(nonatomic, assign) NSRange ylt_selectedRange;

/// UITextView 输入框长度限制
- (void)textViewDidChange:(UITextView *)textView count:(NSUInteger)count;

@end
