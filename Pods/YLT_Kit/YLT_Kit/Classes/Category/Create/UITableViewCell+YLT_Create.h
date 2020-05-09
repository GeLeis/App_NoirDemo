//
//  UITableViewCell+YLT_Create.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import "YLT_CellProtocol.h"

@interface UITableViewCell (YLT_Create)<YLT_CellProtocol>

/**
 当前行上绑定的数据
 */
@property (nonatomic, strong) id cellData;

/**
 绑定数据
 */
- (UITableViewCell *(^)(NSIndexPath *indexPath, id bindData))ylt_cellBindData;
/**
 accessory type
 */
- (UITableViewCell *(^)(UITableViewCellAccessoryType accessoryType))ylt_accessoryType;
/**
 左边image
 */
- (UITableViewCell *(^)(id leftImg))ylt_leftImage;
/**
 左边标题
 */
- (UITableViewCell *(^)(NSString *title))ylt_title;
/**
 详细标题
 */
- (UITableViewCell *(^)(NSString *subTitle))ylt_subTitle;

@end
