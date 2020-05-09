//
//  UICollectionViewCell+YLT_Create.h
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import <UIKit/UIKit.h>
#import "YLT_CellProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface UICollectionViewCell (YLT_Create)<YLT_CellProtocol>

/**
 当前行上绑定的数据
 */
@property (nonatomic, strong) id cellData;

/**
 绑定数据
 */
- (UICollectionViewCell *(^)(NSIndexPath *indexPath, id bindData))ylt_cellBindData;

@end

NS_ASSUME_NONNULL_END
