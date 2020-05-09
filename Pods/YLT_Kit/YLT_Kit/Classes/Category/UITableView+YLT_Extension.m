//
//  UITableView+YLT_Extension.m
//  AFNetworking
//
//  Created by 项普华 on 2018/8/27.
//

#import "UITableView+YLT_Extension.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation UITableView (YLT_Extension)

/**
 批量注册CELL
 
 @param cellClassNames cell的类型名称列表
 */
- (void)registerCell:(NSArray<NSString *> *)cellClassNames {
    @weakify(self);
    [cellClassNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        Class cls = NSClassFromString(obj);
        if (cls) {
            [self registerClass:cls forCellReuseIdentifier:obj];
        } else {
            YLT_LogError(@"%@ 注册失败", obj);
        }
    }];
}

/**
 批量注册HeaderFooterView
 
 @param headerFooterClassNames headerFooter的类型名称列表
 */
- (void)registerHeaderFooterView:(NSArray<NSString *> *)headerFooterClassNames {
    @weakify(self);
    [headerFooterClassNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        Class cls = NSClassFromString(obj);
        if (cls) {
            [self registerClass:cls forHeaderFooterViewReuseIdentifier:obj];
        } else {
            YLT_LogError(@"%@ 注册失败", obj);
        }
    }];
}

@end
