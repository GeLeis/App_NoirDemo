//
//  UITableView+YLT_Create.h
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import "YLT_TableRowModel.h"
#import "YLT_TableSectionModel.h"
#import <Masonry/Masonry.h>

@interface UITableView (YLT_Create)

+ (UITableView *(^)(void))ylt_create;
/**
 列表类别
 */
+ (UITableView *(^)(UIView *superView, void(^layout)(MASConstraintMaker *make), UITableViewStyle style))ylt_createLayout;
/**
 视图的创建frame
 */
+ (UITableView *(^)(UIView *superView, CGRect frame, UITableViewStyle style))ylt_createFrame;
/**
 header
 */
- (UITableView *(^)(UIView *headerView))ylt_tableHeader;
/**
 footer
 */
- (UITableView *(^)(UIView *footerView))ylt_tableFooter;
/**
 列表数据
 */
- (UITableView *(^)(NSArray<YLT_TableSectionModel *> *list))ylt_tableData;
/**
 cell配置
 */
- (UITableView *(^)(CGFloat rowHeight, Class cellClass))ylt_cell;
/**
 单击Cell回调
 */
- (UITableView *(^)(void(^)(UITableViewCell *cell, NSIndexPath *indexPath, id response)))ylt_cellClick;
/**
 设置代理
 */
- (UITableView *(^)(id<UITableViewDataSource, UITableViewDelegate> delegate))ylt_delegate;
/**
 刷新列表
 */
- (UITableView *(^)(void))ylt_reloadData;




/**
 header高度
 */
- (UITableView *(^)(CGFloat headerHeight, UIView *headerView))ylt_sectionHeader;
/**
 footer高度
 */
- (UITableView *(^)(CGFloat footerHeight, UIView *footerView))ylt_sectionFooter;

@end
