//
//  YLT_CollectionSectionModel.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import "YLT_CollectionSectionModel.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation YLT_CollectionSectionModel

/**
 创建SectionData
 */
+ (YLT_CollectionSectionModel *(^)(NSArray *list))ylt_createSectionData {
    @weakify(self);
    return ^id(NSArray *list) {
        @strongify(self);
        YLT_CollectionSectionModel *result = [[YLT_CollectionSectionModel alloc] init];
        result.sectionData = list;
        return result;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_CollectionSectionModel *(^)(CGSize headerSize, Class headerClass))ylt_sectionHeaderView {
    @weakify(self);
    return ^id(CGSize headerSize, Class headerClass) {
        @strongify(self);
        self.sectionHeaderSize = headerSize;
        self.sectionHeaderClass = headerClass;
        self.sectionHeaderTitle = @"";
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_CollectionSectionModel *(^)(CGSize headerSize, NSString *headerTitle))ylt_sectionHeaderTitle {
    @weakify(self);
    return ^id(CGSize headerSize, NSString *headerTitle) {
        @strongify(self);
        self.sectionHeaderSize = headerSize;
        self.sectionHeaderTitle = headerTitle;
        self.sectionHeaderClass = nil;
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_CollectionSectionModel *(^)(CGSize footerSize, Class footerClass))ylt_sectionFooterView {
    @weakify(self);
    return ^id(CGSize footerSize, Class footerClass) {
        @strongify(self);
        self.sectionFooterSize = footerSize;
        self.sectionFooterClass = footerClass;
        self.sectionFooterTitle = @"";
        return self;
    };
}

/**
 sectionHeader 高度
 */
- (YLT_CollectionSectionModel *(^)(CGSize footerSize, NSString *footerTitle))ylt_sectionFooterTitle {
    @weakify(self);
    return ^id(CGSize footerSize, NSString *footerTitle) {
        @strongify(self);
        self.sectionFooterSize = footerSize;
        self.sectionFooterTitle = footerTitle;
        self.sectionFooterClass = nil;
        return self;
    };
}

/**
 cell配置
 */
- (YLT_CollectionSectionModel *(^)(CGSize itemSize, Class cellClass))ylt_cell {
    @weakify(self);
    return ^id(CGSize itemSize, Class cellClass) {
        @strongify(self);
        self.itemSize = itemSize;
        self.cellClass = cellClass;
        return self;
    };
}

#pragma mark - 快速创建对象
/**
 快速创建表头
 
 @param list 数组
 @param headerSize 高度
 @param headerClass view
 @param footerSize footerSize
 @param footerClass footerView
 @return 当前对象
 */
+ (YLT_CollectionSectionModel *)ylt_createSectionData:(NSArray *)list
                                           headerSize:(CGSize)headerSize
                                          headerClass:(Class)headerClass
                                           footerSize:(CGSize)footerSize
                                          footerClass:(Class)footerClass {
    YLT_CollectionSectionModel *result = YLT_CollectionSectionModel
    .ylt_createSectionData(list)
    .ylt_sectionHeaderView(headerSize, headerClass)
    .ylt_sectionFooterView(footerSize, footerClass);
    
    return result;
}

/**
 快速创建对象
 
 @param list 数组
 @param headerString 表头标题
 @param footerString 表尾标题
 @return 当前对象
 */
+ (YLT_CollectionSectionModel *)ylt_createSectionData:(NSArray *)list
                                         headerString:(NSString *)headerString
                                         footerString:(NSString *)footerString {
    YLT_CollectionSectionModel *result = YLT_CollectionSectionModel
    .ylt_createSectionData(list)
    .ylt_sectionHeaderTitle(CGSizeMake(UIScreen.mainScreen.bounds.size.width, headerString.ylt_isValid?36.:0.0), headerString)
    .ylt_sectionFooterTitle(CGSizeMake(UIScreen.mainScreen.bounds.size.width, footerString.ylt_isValid?36.0:0.0), footerString);
    return result;
}

@end
