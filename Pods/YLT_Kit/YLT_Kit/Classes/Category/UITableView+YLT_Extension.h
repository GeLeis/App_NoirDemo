//
//  UITableView+YLT_Extension.h
//  AFNetworking
//
//  Created by 项普华 on 2018/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITableView (YLT_Extension)

/**
 批量注册CELL
 
 @param cellClassNames cell的类型名称列表
 */
- (void)registerCell:(NSArray<NSString *> *)cellClassNames;

/**
 批量注册HeaderFooterView
 
 @param headerFooterClassNames headerFooter的类型名称列表
 */
- (void)registerHeaderFooterView:(NSArray<NSString *> *)headerFooterClassNames;

@end

NS_ASSUME_NONNULL_END
