//
//  PHTableViewCellModel.m
//  Pods
//
//  Created by 項普華 on 2017/8/19.
//
//

#import "YLT_TableSectionModel.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface YLT_TableSectionModel ()

@end

@implementation YLT_TableSectionModel

/**
 创建SectionData
 */
+ (YLT_TableSectionModel *(^)(NSArray *list))ylt_createSectionData {
    @weakify(self);
    return ^id(NSArray *list) {
        @strongify(self);
        YLT_TableSectionModel *result = [[YLT_TableSectionModel alloc] init];
        result.sectionData = list;
        return result;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_TableSectionModel *(^)(CGFloat headerHeight, UIView *header))ylt_sectionHeaderView {
    @weakify(self);
    return ^id(CGFloat headerHeight, UIView *header) {
        @strongify(self);
        self.sectionHeaderHeight = headerHeight;
        self.sectionHeaderView = header;
        self.sectionHeaderTitle = @"";
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_TableSectionModel *(^)(CGFloat headerHeight, NSString *headerTitle))ylt_sectionHeaderTitle {
    @weakify(self);
    return ^id(CGFloat headerHeight, NSString *headerTitle) {
        @strongify(self);
        self.sectionHeaderHeight = headerHeight;
        self.sectionHeaderTitle = headerTitle;
        self.sectionHeaderView = nil;
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_TableSectionModel *(^)(CGFloat footerHeight, UIView *footer))ylt_sectionFooterView {
    @weakify(self);
    return ^id(CGFloat footerHeight, UIView *footer) {
        @strongify(self);
        self.sectionFooterHeight = footerHeight;
        self.sectionFooterView = footer;
        self.sectionFooterTitle = @"";
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_TableSectionModel *(^)(CGFloat footerHeight, NSString *footerTitle))ylt_sectionFooterTitle {
    @weakify(self);
    return ^id(CGFloat footerHeight, NSString *footerTitle) {
        @strongify(self);
        self.sectionFooterHeight = footerHeight;
        self.sectionFooterTitle = footerTitle;
        self.sectionFooterView = nil;
        return self;
    };
}

/**
 cell配置
 */
- (YLT_TableSectionModel *(^)(CGFloat rowHeight, Class cellClass))ylt_cell {
    @weakify(self);
    return ^id(CGFloat rowHeight, Class cellClass) {
        @strongify(self);
        self.rowHeight = rowHeight;
        self.cellClass = cellClass;
        return self;
    };
}

#pragma mark - 快速创建对象
/**
 快速创建表头
 
 @param list 数组
 @param headerHeight 高度
 @param headerView view
 @param footerHeight footerHeight
 @param footerView footerView
 @return 当前对象
 */
+ (YLT_TableSectionModel *)ylt_createSectionData:(NSArray *)list
                                    headerHeight:(CGFloat)headerHeight
                                      headerView:(UIView *)headerView
                                    footerHeight:(CGFloat)footerHeight
                                      footerView:(UIView *)footerView {
    YLT_TableSectionModel *result = YLT_TableSectionModel
                                    .ylt_createSectionData(list)
                                    .ylt_sectionHeaderView(headerHeight, headerView)
                                    .ylt_sectionFooterView(footerHeight, footerView);
    
    return result;
}

/**
 快速创建对象
 
 @param list 数组
 @param headerString 表头标题
 @param footerString 表尾标题
 @return 当前对象
 */
+ (YLT_TableSectionModel *)ylt_createSectionData:(NSArray *)list
                                    headerString:(NSString *)headerString
                                    footerString:(NSString *)footerString {
    YLT_TableSectionModel *result = YLT_TableSectionModel
                                    .ylt_createSectionData(list)
                                    .ylt_sectionHeaderTitle(36., headerString)
                                    .ylt_sectionFooterTitle(36., footerString);
    return result;
}


@end
