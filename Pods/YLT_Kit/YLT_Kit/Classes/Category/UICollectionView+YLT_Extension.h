//
//  UICollectionView+YLT_Extension.h
//  AFNetworking
//
//  Created by 项普华 on 2018/8/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionView (YLT_Extension)

/**
 批量注册CELL

 @param cellClassNames cell的类型名称列表
 */
- (void)registerCell:(NSArray<NSString *> *)cellClassNames;

/**
 批量注册Header

 @param headerClassNames header的类型名称列表
 */
- (void)registerHeader:(NSArray<NSString *> *)headerClassNames;

/**
 批量注册Footer

 @param footerClassNames footer的类型名称列表
 */
- (void)registerFooter:(NSArray<NSString *> *)footerClassNames;

@end

NS_ASSUME_NONNULL_END
