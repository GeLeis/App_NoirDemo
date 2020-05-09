//
//  YLT_CellProtocol.h
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@protocol YLT_CellProtocol <NSObject>

@optional
/**
 类型配置
 
 @return UITableViewCellStyle
 */
- (UITableViewCellStyle)ylt_cellStyle;
/**
 UI配置
 */
- (void)ylt_configUI;
/**
 数据绑定
 */
- (void)ylt_indexPath:(NSIndexPath *)indexPath bindData:(id)data;

@end

NS_ASSUME_NONNULL_END
