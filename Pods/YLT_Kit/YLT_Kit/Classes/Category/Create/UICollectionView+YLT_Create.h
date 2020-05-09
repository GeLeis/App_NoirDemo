//
//  UICollectionView+YLT_Create.h
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import <UIKit/UIKit.h>
#import "YLT_CollectionRowModel.h"
#import "YLT_CollectionSectionModel.h"
#import <Masonry/Masonry.h>

@interface UICollectionView (YLT_Create)

+ (UICollectionView *(^)(void))ylt_create;
/**
 列表类别
 */
+ (UICollectionView *(^)(UIView *superView, void(^layout)(MASConstraintMaker *make)))ylt_createLayout;
/**
 视图的创建frame
 */
+ (UICollectionView *(^)(UIView *superView, CGRect frame))ylt_createFrame;
/**
 列表数据
 */
- (UICollectionView *(^)(NSArray<YLT_CollectionSectionModel *> *list))ylt_collectionData;
/**
 spacing
 */
- (UICollectionView *(^)(CGFloat spacing))ylt_spacing;
/**
 cell配置
 */
- (UICollectionView *(^)(CGSize itemSize, Class cellClass))ylt_cell;
/**
 单击Cell回调
 */
- (UICollectionView *(^)(NSString *(^)(NSIndexPath *indexPath, id response)))ylt_cellIdentify;
/**
 单击Cell回调
 */
- (UICollectionView *(^)(void(^)(UICollectionViewCell *cell, NSIndexPath *indexPath, id response)))ylt_cellClick;
/**
 设置代理
 */
- (UICollectionView *(^)(id<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource> delegate))ylt_delegate;
/**
 刷新列表
 */
- (UICollectionView *(^)(void))ylt_reloadData;


/**
 header高度
 */
- (UICollectionView *(^)(CGSize headerSize, UIView *headerView))ylt_sectionHeader;
/**
 footer高度
 */
- (UICollectionView *(^)(CGSize footerSize, UIView *footerView))ylt_sectionFooter;

@end
