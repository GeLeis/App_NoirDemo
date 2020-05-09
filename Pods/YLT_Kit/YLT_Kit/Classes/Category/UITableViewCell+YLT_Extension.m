//
//  UITableViewCell+YLT_Extension.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/9/3.
//

#import "UITableViewCell+YLT_Extension.h"

@implementation UITableViewCell (YLT_Extension)

@dynamic ylt_targetTableView;

- (UITableView *)ylt_targetTableView {
    UITableView *result = (UITableView *)self.superview;
    while (![result isKindOfClass:UITableView.class]) {
        result = (UITableView *)result.superview;
    }
    
    return result;
}

@end
