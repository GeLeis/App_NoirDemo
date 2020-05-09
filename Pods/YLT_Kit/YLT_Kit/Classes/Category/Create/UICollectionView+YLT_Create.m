//
//  UICollectionView+YLT_Create.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import "UICollectionView+YLT_Create.h"
#import <objc/message.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import "UITableViewCell+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIView+YLT_BaseView.h"
#import "UICollectionViewCell+YLT_Create.h"
#import "YLT_CollectionReusableView.h"

@interface UICollectionView (YLT_Data)

/**
 传入的数据
 */
@property (nonatomic, strong) NSArray<YLT_CollectionSectionModel *> *tableData;
/**
 cell class
 */
@property (nonatomic, strong) Class cellClass;
/**
 cell size
 */
@property (nonatomic, assign) CGSize cellSize;
/**
 间隔
 */
@property (nonatomic, assign) CGFloat spacing;
/**
 自定义代理
 */
@property (nonatomic, strong) id<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout> customDelegate;
/**
 cell 点击回调
 */
@property (nonatomic, copy) void(^cellBlock)(UICollectionViewCell *cell, NSIndexPath *indexPath, id response);

@end

@implementation UICollectionView (YLT_Data)

@dynamic tableData;

- (void)setTableData:(NSArray<YLT_CollectionSectionModel *> *)tableData {
    if (tableData && [tableData isKindOfClass:[NSArray class]]) {
        objc_setAssociatedObject(self, @selector(tableData), tableData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [tableData enumerateObjectsUsingBlock:^(YLT_CollectionSectionModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([obj isKindOfClass:[YLT_CollectionSectionModel class]] && obj.cellClass) {
                if (obj.sectionHeaderClass) {
                    [self registerClass:obj.sectionHeaderClass forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(obj.sectionHeaderClass)];
                }
                if (obj.sectionFooterClass) {
                    [self registerClass:obj.sectionFooterClass forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(obj.sectionFooterClass)];
                }
                [self registerClass:obj.cellClass forCellWithReuseIdentifier:NSStringFromClass(obj.cellClass)];
                if ([obj.sectionData isKindOfClass:[NSArray class]]) {
                    [obj.sectionData enumerateObjectsUsingBlock:^(YLT_CollectionRowModel *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                        if ([obj isKindOfClass:[YLT_CollectionRowModel class]] && obj.cellClass) {
                            [self registerClass:obj.cellClass forCellWithReuseIdentifier:NSStringFromClass(obj.cellClass)];
                        }
                    }];
                }
            }
        }];
    }
}

- (NSArray<YLT_CollectionSectionModel *> *)tableData {
    return objc_getAssociatedObject(self, @selector(tableData));
}

- (void)setCellClass:(Class)cellClass {
    objc_setAssociatedObject(self, @selector(cellClass), cellClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Class)cellClass {
    return objc_getAssociatedObject(self, @selector(cellClass));
}

- (void)setCellSize:(CGSize)cellSize {
    objc_setAssociatedObject(self, @selector(cellSize), @(cellSize), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGSize)cellSize {
    return [objc_getAssociatedObject(self, @selector(cellSize)) CGSizeValue];
}

- (void)setSpacing:(CGFloat)spacing {
    objc_setAssociatedObject(self, @selector(spacing), @(spacing), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)spacing {
    return [objc_getAssociatedObject(self, @selector(spacing)) floatValue];
}

- (void)setCustomDelegate:(id<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>)customDelegate {
    objc_setAssociatedObject(self, @selector(customDelegate), customDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource>)customDelegate {
    return objc_getAssociatedObject(self, @selector(customDelegate));
}

- (void)setCellBlock:(void(^)(UICollectionViewCell *cell, NSIndexPath *indexPath, id response))cellBlock {
    objc_setAssociatedObject(self, @selector(cellBlock), cellBlock, OBJC_ASSOCIATION_COPY);
}

- (void(^)(UICollectionViewCell *cell, NSIndexPath *indexPath, id response))cellBlock {
    return objc_getAssociatedObject(self, @selector(cellBlock));
}

@end


#pragma mark - UITableViewDataSource
@interface UICollectionView (YLT_DataSource)<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@end

@implementation UICollectionView (YLT_DataSource)
//
//#pragma mark - header footer
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForHeaderInSection:)]) {
//        return [self.customDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForHeaderInSection:section];
//    }
//
//    YLT_CollectionSectionModel *data = self.tableData[section];
//    if ([data isKindOfClass:[YLT_CollectionSectionModel class]]) {
//        if (CGSizeEqualToSize(data.sectionHeaderSize, CGSizeZero)) {
//            if (data.sectionHeaderClass) {
//                return CGSizeMake(collectionView.ylt_width, 44.);
//            } else if (data.sectionHeaderTitle.ylt_isValid) {
//                return CGSizeMake(collectionView.ylt_width, 36.);
//            }
//        } else {
//            return data.sectionHeaderSize;
//        }
//    }
//    return CGSizeZero;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:layout:referenceSizeForFooterInSection:)]) {
//        return [self.customDelegate collectionView:collectionView layout:collectionViewLayout referenceSizeForFooterInSection:section];
//    }
//    YLT_CollectionSectionModel *data = self.tableData[section];
//    if ([data isKindOfClass:[YLT_CollectionSectionModel class]]) {
//        if (CGSizeEqualToSize(data.sectionFooterSize, CGSizeZero)) {
//            if (data.sectionFooterClass) {
//                return CGSizeMake(collectionView.ylt_width, 44.);
//            } else if (data.sectionFooterTitle.ylt_isValid) {
//                return CGSizeMake(collectionView.ylt_width, 36.);
//            }
//        } else {
//            return data.sectionFooterSize;
//        }
//    }
//    return CGSizeZero;
//}
//
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:viewForSupplementaryElementOfKind:atIndexPath:)]) {
//        return [self.customDelegate collectionView:collectionView viewForSupplementaryElementOfKind:kind atIndexPath:indexPath];
//    }
//    UICollectionReusableView *reuseableView = nil;
//    YLT_CollectionSectionModel *data = self.tableData[indexPath.section];
//    if ([data isKindOfClass:[YLT_CollectionSectionModel class]]) {
//        if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
//            if (data.sectionHeaderClass) {
//                reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(data.sectionHeaderClass) forIndexPath:indexPath];
//            } else if (data.sectionHeaderTitle.ylt_isValid) {
//                reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(YLT_CollectionReusableView.class) forIndexPath:indexPath];
//                [((YLT_CollectionReusableView *) reuseableView) performSelector:@selector(ylt_indexPath:bindData:) withObject:indexPath withObject:data.sectionHeaderTitle];
//            }
//        } else if ([kind isEqualToString:UICollectionElementKindSectionFooter]) {
//            if (data.sectionFooterClass) {
//                reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(data.sectionFooterClass) forIndexPath:indexPath];
//            } else if (data.sectionFooterTitle.ylt_isValid) {
//                reuseableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:NSStringFromClass(YLT_CollectionReusableView.class) forIndexPath:indexPath];
//                [((YLT_CollectionReusableView *) reuseableView) performSelector:@selector(ylt_indexPath:bindData:) withObject:indexPath withObject:data.sectionFooterTitle];
//            }
//        }
//        if (![reuseableView isKindOfClass:YLT_CollectionReusableView.class] && [reuseableView conformsToProtocol:@protocol(YLT_CellProtocol)] && [reuseableView respondsToSelector:@selector(ylt_indexPath:bindData:)]) {
//            [reuseableView performSelector:@selector(ylt_indexPath:bindData:) withObject:indexPath withObject:data];
//        }
//    }
//
//    return reuseableView;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:layout:minimumLineSpacingForSectionAtIndex:)]) {
//        return [self.customDelegate collectionView:collectionView layout:collectionViewLayout minimumLineSpacingForSectionAtIndex:section];
//    }
//    return self.spacing;
//}
//
//- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:layout:minimumInteritemSpacingForSectionAtIndex:)]) {
//        return [self.customDelegate collectionView:collectionView layout:collectionViewLayout minimumInteritemSpacingForSectionAtIndex:section];
//    }
//    return self.spacing;
//}
//
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
//        return [self.customDelegate collectionView:collectionView layout:collectionViewLayout insetForSectionAtIndex:section];
//    }
//    return UIEdgeInsetsMake(self.spacing, self.spacing, self.spacing, self.spacing);
//}
//
//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(numberOfSectionsInCollectionView:)]) {
//        return [self.customDelegate numberOfSectionsInCollectionView:collectionView];
//    }
//    return self.tableData.count;
//}
//
//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:numberOfItemsInSection:)]) {
//        return [self.customDelegate collectionView:collectionView numberOfItemsInSection:section];
//    }
//    YLT_CollectionSectionModel *data = self.tableData[section];
//    if ([data isKindOfClass:[YLT_CollectionSectionModel class]]) {
//        if ([data.sectionData isKindOfClass:[NSArray class]]) {
//            return data.sectionData.count;
//        }
//    }
//    return 0;
//}
//
//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:layout:sizeForItemAtIndexPath:)]) {
//        return [self.customDelegate collectionView:collectionView layout:collectionViewLayout sizeForItemAtIndexPath:indexPath];
//    }
//    YLT_CollectionSectionModel *data = self.tableData[indexPath.section];
//    if ([data isKindOfClass:[YLT_CollectionSectionModel class]]) {
//        if ([data.sectionData isKindOfClass:[NSArray class]]) {
//            YLT_CollectionRowModel *rowData = data.sectionData[indexPath.section];
//            if ([rowData isKindOfClass:[YLT_CollectionRowModel class]] && !CGSizeEqualToSize(CGSizeZero, rowData.itemSize)) {
//                return rowData.itemSize;
//            }
//        }
//        if (!CGSizeEqualToSize(CGSizeZero, data.itemSize)) {
//            return data.itemSize;
//        }
//    }
//    return self.cellSize;
//}
//
//- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:cellForItemAtIndexPath:)]) {
//        return [self.customDelegate collectionView:collectionView cellForItemAtIndexPath:indexPath];
//    }
//    UICollectionViewCell *cell = nil;
//    YLT_CollectionSectionModel *data = self.tableData[indexPath.section];
//    if ([data isKindOfClass:[YLT_CollectionSectionModel class]]) {
//        if ([data.sectionData isKindOfClass:[NSArray class]]) {
//            YLT_CollectionRowModel *rowData = data.sectionData[indexPath.row];
//            if ([rowData isKindOfClass:[YLT_CollectionRowModel class]] && rowData.cellClass) {
//                cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(rowData.cellClass) forIndexPath:indexPath];
//            }
//            if (cell == nil && data.cellClass) {
//                cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(data.cellClass) forIndexPath:indexPath];
//            }
//            if (cell == nil && self.cellClass) {
//                cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass(self.cellClass) forIndexPath:indexPath];
//            }
//            if ([cell conformsToProtocol:@protocol(YLT_CellProtocol)] && [cell respondsToSelector:@selector(ylt_indexPath:bindData:)]) {
//                [cell performSelector:@selector(ylt_indexPath:bindData:) withObject:indexPath withObject:rowData];
//            }
//        } else {
//            if ([cell conformsToProtocol:@protocol(YLT_CellProtocol)] && [cell respondsToSelector:@selector(ylt_indexPath:bindData:)]) {
//                [cell performSelector:@selector(ylt_indexPath:bindData:) withObject:indexPath withObject:data];
//            }
//        }
//    }
//
//    return cell;
//}
//
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
//    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(collectionView:didSelectItemAtIndexPath:)]) {
//        return [self.customDelegate collectionView:collectionView didSelectItemAtIndexPath:indexPath];
//    }
//    if (self.cellBlock) {
//        UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
//        self.cellBlock(cell, indexPath, cell.cellData);
//    }
//}

@end




@implementation UICollectionView (YLT_Create)

+ (UICollectionView *(^)(void))ylt_create {
    @weakify(self);
    return ^id() {
        @strongify(self);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(50, 50);
        UICollectionView *result = [[[self class] alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        result.backgroundColor = UIColor.clearColor;
        result.ylt_delegate(nil);
        return result;
    };
}

/**
 列表类别
 */
+ (UICollectionView *(^)(UIView *superView, void(^layout)(MASConstraintMaker *make)))ylt_createLayout {
    @weakify(self);
    return ^id(UIView *superView, void(^layout)(MASConstraintMaker *make)) {
        @strongify(self);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(50, 50);
        UICollectionView *result = [[[self class] alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
        result.backgroundColor = UIColor.clearColor;
        result.ylt_delegate(nil);
        if (superView) {
            [superView addSubview:result];
            if (layout) {
                [result mas_makeConstraints:layout];
            } else {
                [result mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(superView);
                }];
            }
        }
        return result;
    };
}

/**
 视图的创建frame
 */
+ (UICollectionView *(^)(UIView *superView, CGRect frame))ylt_createFrame {
    @weakify(self);
    return ^id(UIView *superView, CGRect frame) {
        @strongify(self);
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.itemSize = CGSizeMake(50, 50);
        UICollectionView *result = [[[self class] alloc] initWithFrame:frame collectionViewLayout:flowLayout];
        result.backgroundColor = UIColor.clearColor;
        result.ylt_delegate(nil);
        if (superView) {
            [superView addSubview:result];
        }
        return result;
    };
}

/**
 列表数据
 */
- (UICollectionView *(^)(NSArray<YLT_CollectionSectionModel *> *list))ylt_collectionData {
    @weakify(self);
    return ^id(NSArray<YLT_CollectionSectionModel *> *list) {
        @strongify(self);
        self.tableData = list;
        [self reloadData];
        return self;
    };
}

/**
 spacing
 */
- (UICollectionView *(^)(CGFloat spacing))ylt_spacing {
    @weakify(self);
    return ^id(CGFloat spacing) {
        @strongify(self);
        self.spacing = spacing;
        return self;
    };
}

/**
 cell配置
 */
- (UICollectionView *(^)(CGSize itemSize, Class cellClass))ylt_cell {
    @weakify(self);
    return ^id(CGSize itemSize, Class cellClass) {
        @strongify(self);
        [self registerClass:cellClass forCellWithReuseIdentifier:NSStringFromClass(cellClass)];
        ((UICollectionViewFlowLayout *) self.collectionViewLayout).itemSize = itemSize;
        self.cellSize = itemSize;
        self.cellClass = cellClass;
        return self;
    };
}

/**
 单击Cell回调
 */
- (UICollectionView *(^)(void(^)(UICollectionViewCell *cell, NSIndexPath *indexPath, id response)))ylt_cellClick {
    @weakify(self);
    return ^id(void(^cellActionBlock)(UICollectionViewCell *cell, NSIndexPath *indexPath, id response)) {
        @strongify(self);
        self.cellBlock = cellActionBlock;
        return self;
    };
}

/**
 设置代理
 */
- (UICollectionView *(^)(id<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource> delegate))ylt_delegate {
    return ^id(id<UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource> delegate) {
        [self registerClass:YLT_CollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass(YLT_CollectionReusableView.class)];
        [self registerClass:YLT_CollectionReusableView.class forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:NSStringFromClass(YLT_CollectionReusableView.class)];
        self.delegate = self;
        self.dataSource = self;
        self.customDelegate = delegate;
        return self;
    };
}

/**
 刷新列表
 */
- (UICollectionView *(^)(void))ylt_reloadData {
    @weakify(self);
    return ^id() {
        @strongify(self);
        [self reloadData];
        return self;
    };
}


/**
 header高度
 */
- (UICollectionView *(^)(CGSize headerSize, UIView *headerView))ylt_sectionHeader {
    @weakify(self);
    return ^id(CGSize headerSize, UIView *headerView) {
        @strongify(self);
        return self;
    };
}

/**
 footer高度
 */
- (UICollectionView *(^)(CGSize footerSize, UIView *footerView))ylt_sectionFooter {
    @weakify(self);
    return ^id(CGSize headerSize, UIView *headerView) {
        @strongify(self);
        return self;
    };
}

@end
