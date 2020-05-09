//
//  UITextView+YLT_Extension.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/21.
//

#import "UITextView+YLT_Extension.h"

@implementation UITextView (YLT_Extension)

/// UITextView 输入框长度限制
- (void)textViewDidChange:(UITextView *)textView count:(NSUInteger)count {
    [textView.undoManager removeAllActions];
    
    UITextRange *selectedRange = [textView markedTextRange];
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    //没有高亮选择的字，则对已输入的文字进行字数统计和限制
    if (!position) {
        if (textView.text.length > count) {
            NSRange rangeIndex = [textView.text rangeOfComposedCharacterSequenceAtIndex:count];
            if (rangeIndex.length == count) {
                [textView setText:[textView.text substringToIndex:count]];
            } else {
                NSRange rangeRange = [textView.text rangeOfComposedCharacterSequencesForRange:NSMakeRange(0, count)];
                [textView setText:[textView.text substringWithRange:rangeRange]];
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

@end
