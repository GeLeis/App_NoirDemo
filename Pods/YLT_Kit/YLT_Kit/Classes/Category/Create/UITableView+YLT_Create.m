//
//  UITableView+YLT_Create.m
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UITableView+YLT_Create.h"
#import <objc/message.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import "UITableViewCell+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface UITableView (YLT_Data)

/**
 传入的数据
 */
@property (nonatomic, strong) NSArray<YLT_TableSectionModel *> *tableData;
/**
 cell class
 */
@property (nonatomic, strong) Class cellClass;
@property (nonatomic, strong) id<UITableViewDataSource, UITableViewDelegate> customDelegate;
/**
 cell 点击回调
 */
@property (nonatomic, copy) void(^cellBlock)(UITableViewCell *cell, NSIndexPath *indexPath, id response);

@end

@implementation UITableView (YLT_Data)

@dynamic tableData;

- (void)setTableData:(NSArray<YLT_TableSectionModel *> *)tableData {
    if (tableData && [tableData isKindOfClass:[NSArray class]]) {
        objc_setAssociatedObject(self, @selector(tableData), tableData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
}

- (NSArray<YLT_TableSectionModel *> *)tableData {
    return objc_getAssociatedObject(self, @selector(tableData));
}

- (void)setCellClass:(Class)cellClass {
    objc_setAssociatedObject(self, @selector(cellClass), cellClass, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (Class)cellClass {
    return objc_getAssociatedObject(self, @selector(cellClass));
}

- (void)setCustomDelegate:(id<UITableViewDataSource,UITableViewDelegate>)customDelegate {
    objc_setAssociatedObject(self, @selector(customDelegate), customDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id<UITableViewDataSource,UITableViewDelegate>)customDelegate {
    return objc_getAssociatedObject(self, @selector(customDelegate));
}

- (void)setCellBlock:(void(^)(UITableViewCell *cell, NSIndexPath *indexPath, id response))cellBlock {
    objc_setAssociatedObject(self, @selector(cellBlock), cellBlock, OBJC_ASSOCIATION_COPY);
}

- (void(^)(UITableViewCell *cell, NSIndexPath *indexPath, id response))cellBlock {
    return objc_getAssociatedObject(self, @selector(cellBlock));
}

@end

#pragma mark - UITableViewDataSource
@interface UITableView (YLT_DataSource)<UITableViewDelegate, UITableViewDataSource>

@end

@implementation UITableView (YLT_DataSource)

#pragma mark - header footer
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:heightForHeaderInSection:)]) {
        return [self.customDelegate tableView:tableView heightForHeaderInSection:section];
    }
    
    YLT_TableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[YLT_TableSectionModel class]]) {
        if (data.sectionHeaderHeight != 0) {
            return data.sectionHeaderHeight;
        } else if (data.sectionHeaderView ) {
            return 44.;
        } else if (data.sectionHeaderTitle) {
            return 36.;
        }
    }
    return CGFLOAT_MIN;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:heightForFooterInSection:)]) {
        return [self.customDelegate tableView:tableView heightForFooterInSection:section];
    }
    YLT_TableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[YLT_TableSectionModel class]]) {
        if (data.sectionFooterHeight != 0) {
            return data.sectionFooterHeight;
        } else if (data.sectionFooterView) {
            return 44.;
        } else if (data.sectionFooterTitle) {
            return 36.;
        }
    }
    return CGFLOAT_MIN;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:viewForHeaderInSection:)]) {
        return [self.customDelegate tableView:tableView viewForHeaderInSection:section];
    }
    YLT_TableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[YLT_TableSectionModel class]]) {
        return data.sectionHeaderView?:nil;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:viewForFooterInSection:)]) {
        return [self.customDelegate tableView:tableView viewForFooterInSection:section];
    }
    YLT_TableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[YLT_TableSectionModel class]]) {
        return data.sectionFooterView?:nil;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:titleForHeaderInSection:)]) {
        return [self.customDelegate tableView:tableView titleForHeaderInSection:section];
    }
    YLT_TableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[YLT_TableSectionModel class]]) {
        return ([data.sectionHeaderTitle ylt_isValid])?data.sectionHeaderTitle:nil;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:titleForFooterInSection:)]) {
        return [self.customDelegate tableView:tableView titleForFooterInSection:section];
    }
    YLT_TableSectionModel *data = self.tableData[section];
    if ([data isKindOfClass:[YLT_TableSectionModel class]]) {
        return ([data.sectionFooterTitle ylt_isValid])?data.sectionFooterTitle:nil;
    }
    return nil;
}

#pragma mark - UITableViewDelegate UITableVIewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(numberOfSectionsInTableView:)]) {
        return [self.customDelegate numberOfSectionsInTableView:tableView];
    }
    return self.tableData.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:numberOfRowsInSection:)]) {
        return [self.customDelegate tableView:tableView numberOfRowsInSection:section];
    }
    YLT_TableSectionModel *sectionData = self.tableData[section];
    return sectionData.sectionData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        return [self.customDelegate tableView:tableView heightForRowAtIndexPath:indexPath];
    }
    YLT_TableSectionModel *sectionData = self.tableData[indexPath.section];
    YLT_TableRowModel *data = sectionData.sectionData[indexPath.row];
    CGFloat height = 0;
    if (self.rowHeight != UITableViewAutomaticDimension) {
        if ([data isKindOfClass:[YLT_TableRowModel class]]) {
            YLT_TableRowModel *model = data;
            height = model.rowHeight;
        } else {
            height = sectionData.rowHeight;
        }
        if (height == 0) {
            height = self.rowHeight;
        }
    }
    if (height == 0) {//需要代码自己计算行高
        self.rowHeight = UITableViewAutomaticDimension;
        return self.rowHeight;
    }
    return height;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:cellForRowAtIndexPath:)]) {
        return [self.customDelegate tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    YLT_TableSectionModel *sectionData = self.tableData[indexPath.section];
    YLT_TableRowModel *data = sectionData.sectionData[indexPath.row];
    Class cellClass;
    if ([data isKindOfClass:[YLT_TableRowModel class]] && data.cellClass) {
        cellClass = data.cellClass;
    } else if (sectionData.cellClass){
        cellClass = sectionData.cellClass;
    }
    cellClass = cellClass?:self.cellClass;
    if (!cellClass) {
        cellClass = [UITableViewCell class];
    }
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    if (cell == nil) {
        [tableView registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass(cellClass)];
    }
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELL"];
    }
    
    cell.ylt_cellBindData(indexPath, data);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.customDelegate && [self.customDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        return [self.customDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
    if (self.cellBlock) {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        self.cellBlock(cell, indexPath, cell.cellData);
    }
}


@end


@implementation UITableView (YLT_Create)

+ (UITableView *(^)(void))ylt_create {
    @weakify(self);
    return ^id() {
        @strongify(self);
        UITableView *result = [[[self class] alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        result.rowHeight = 44.;
        result.ylt_delegate(nil);
        return result;
    };
}
/**
 列表类别
 */
+ (UITableView *(^)(UIView *superView, void(^layout)(MASConstraintMaker *make), UITableViewStyle style))ylt_createLayout {
    @weakify(self);
    return ^id(UIView *superView, void(^layout)(MASConstraintMaker *make), UITableViewStyle style) {
        @strongify(self);
        UITableView *result = [[[self class] alloc] initWithFrame:CGRectZero style:style];
        result.rowHeight = 44.;
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
+ (UITableView *(^)(UIView *superView, CGRect frame, UITableViewStyle style))ylt_createFrame {
    @weakify(self);
    return ^id(UIView *superView, CGRect frame, UITableViewStyle style) {
        @strongify(self);
        UITableView *result = [[[self class] alloc] initWithFrame:frame style:style];
        result.ylt_delegate(nil);
        if (superView) {
            [superView addSubview:result];
        }
        return result;
    };
}

/**
 header高度
 */
- (UITableView *(^)(UIView *headerView))ylt_tableHeader {
    @weakify(self);
    return ^id(UIView *headerView) {
        @strongify(self);
        self.tableHeaderView = headerView;
        return self;
    };
}
/**
 footer高度
 */
- (UITableView *(^)(UIView *footerView))ylt_tableFooter {
    @weakify(self);
    return ^id(UIView *footerView) {
        @strongify(self);
        self.tableFooterView = footerView;
        return self;
    };
}
/**
 列表数据
 */
- (UITableView *(^)(NSArray<YLT_TableSectionModel *> *list))ylt_tableData {
    @weakify(self);
    return ^id(NSArray<YLT_TableSectionModel *> *list) {
        @strongify(self);
        self.tableData = list;
        [self reloadData];
        return self;
    };
}
/**
 cell配置
 */
- (UITableView *(^)(CGFloat rowHeight, Class cellClass))ylt_cell {
    @weakify(self);
    return ^id(CGFloat rowHeight, Class cellClass) {
        @strongify(self);
        self.rowHeight = rowHeight;
        self.cellClass = cellClass;
        [self registerClass:cellClass forCellReuseIdentifier:NSStringFromClass(cellClass)];
        return self;
    };
}

/**
 单击Cell回调
 */
- (UITableView *(^)(void(^)(UITableViewCell *cell, NSIndexPath *indexPath, id response)))ylt_cellClick {
    @weakify(self);
    return ^id(void(^cellActionBlock)(UITableViewCell *cell, NSIndexPath *indexPath, id response)) {
        @strongify(self);
        self.cellBlock = cellActionBlock;
        return self;
    };
}

/**
 设置代理
 */
- (UITableView *(^)(id<UITableViewDataSource, UITableViewDelegate> delegate))ylt_delegate {
    @weakify(self);
    return ^id(id delegate) {
        @strongify(self);
        self.customDelegate = delegate;
        self.delegate = self;
        self.dataSource = self;
        return self;
    };
}

/**
 刷新列表
 */
- (UITableView *(^)(void))ylt_reloadData {
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
- (UITableView *(^)(CGFloat headerHeight, UIView *headerView))ylt_sectionHeader {
    @weakify(self);
    return ^id(CGFloat headerHeight, UIView *headerView) {
        @strongify(self);
        return self;
    };
}
/**
 footer高度
 */
- (UITableView *(^)(CGFloat footerHeight, UIView *footerView))ylt_sectionFooter {
    @weakify(self);
    return ^id(CGFloat footerHeight, UIView *footerView) {
        @strongify(self);
        return self;
    };
}

@end
