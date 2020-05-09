//
//  YLT_CollectionSectionModel.h
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import <Foundation/Foundation.h>

@interface YLT_CollectionSectionModel : NSObject

/**
 创建SectionData
 */
+ (YLT_CollectionSectionModel *(^)(NSArray *list))ylt_createSectionData;

/**
 sectionHeader 高度
 */
- (YLT_CollectionSectionModel *(^)(CGSize headerSize, Class headerClass))ylt_sectionHeaderView;

/**
 sectionHeader 高度
 */
- (YLT_CollectionSectionModel *(^)(CGSize headerSize, NSString *headerTitle))ylt_sectionHeaderTitle;

/**
 sectionHeader 高度
 */
- (YLT_CollectionSectionModel *(^)(CGSize footerSize, Class footerClass))ylt_sectionFooterView;

/**
 sectionHeader 高度
 */
- (YLT_CollectionSectionModel *(^)(CGSize footerSize, NSString *footerTitle))ylt_sectionFooterTitle;

/**
 cell配置
 */
- (YLT_CollectionSectionModel *(^)(CGSize itemSize, Class cellClass))ylt_cell;

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
                                          footerClass:(Class)footerClass;

/**
 快速创建对象
 
 @param list 数组
 @param headerString 表头标题
 @param footerString 表尾标题
 @return 当前对象
 */
+ (YLT_CollectionSectionModel *)ylt_createSectionData:(NSArray *)list
                                         headerString:(NSString *)headerString
                                         footerString:(NSString *)footerString;

#pragma mark - 属性  以下参数不需要管
/**
 数据源
 */
@property (nonatomic, strong) NSArray *sectionData;

/**
 section header height
 */
@property (nonatomic, assign) CGSize sectionHeaderSize;

/**
 section header title
 */
@property (nonatomic, strong) NSString *sectionHeaderTitle;

/**
 section header view
 */
@property (nonatomic, strong) Class sectionHeaderClass;

/**
 section footer height
 */
@property (nonatomic, assign) CGSize sectionFooterSize;

/**
 section footer view
 */
@property (nonatomic, strong) Class sectionFooterClass;

/**
 section footer title
 */
@property (nonatomic, strong) NSString *sectionFooterTitle;

/**
 row height
 */
@property (nonatomic, assign) CGSize itemSize;
/**
 默认使用 row data中的cell 如果找不到则使用此处的cellClass
 */
@property (nonatomic, strong) Class cellClass;

@end
