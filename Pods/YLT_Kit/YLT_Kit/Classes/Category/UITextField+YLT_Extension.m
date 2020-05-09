//
//  UITextField+YLT_Extension.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/21.
//

#import "UITextField+YLT_Extension.h"

@implementation UITextField (YLT_Extension)

/// UITextField 输入框长度限制
- (void)textFieldDidChange:(UITextField *)textField count:(NSUInteger)count {
    [textField.undoManager removeAllActions];
    
    UITextRange *selectedRange = [textField markedTextRange];
    UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (textField.text.length > count) {
            NSRange rangeIndex = [textField.text rangeOfComposedCharacterSequenceAtIndex:count];
            if (rangeIndex.length == count) {
                [textField setText:[textField.text substringToIndex:count]];
            } else {
                NSRange rangeRange = [textField.text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, count)];
                [textField setText:[textField.text substringWithRange:rangeRange]];
            }
        }
    }
}

-(NSRange)ylt_selectedRange {
    NSInteger location = [self offsetFromPosition:self.beginningOfDocument toPosition:self.selectedTextRange.start];
    NSInteger length = [self offsetFromPosition:self.selectedTextRange.start toPosition:self.selectedTextRange.end];
    return NSMakeRange(location, length);
}

-(void)setYlt_selectedRange:(NSRange)ylt_selectedRange {
    UITextPosition *startPosition = [self positionFromPosition:self.beginningOfDocument offset:ylt_selectedRange.location];
    UITextPosition *endPosition = [self positionFromPosition:self.beginningOfDocument offset:ylt_selectedRange.location + ylt_selectedRange.length];
    UITextRange *selectedTextRange = [self textRangeFromPosition:startPosition toPosition:endPosition];
    [self setSelectedTextRange:selectedTextRange];
}

/// 输入金额字符串进行验证
- (BOOL)amountStringIsEnteredForValidation:(NSString *)string {
    if ([string isEqualToString:@"."]) {
        self.text = @"0.";
        return NO;
    }
    if (string.length > 1) {
        if ([string rangeOfString:@"."].location == NSNotFound && string.floatValue == 0) {
            self.text = @"0";
            return NO;
        }
    }
    NSArray *arrayCount = [string componentsSeparatedByString:@"."];
    if (arrayCount.count > 2) {
        return NO;
    } else if ([string rangeOfString:@"."].location != NSNotFound) {
        //只能有两位小数
        NSRange tempRange = [string rangeOfString:@"."];
        if (string.length - NSMaxRange(tempRange) > 2) {
            return NO;
        }
    }
    return YES;
}

@end
