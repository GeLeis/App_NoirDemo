//
//  YLT_CollectionRowModel.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import "YLT_CollectionRowModel.h"

@implementation YLT_CollectionRowModel

/**
 cell 数据
 */
+ (YLT_CollectionRowModel *(^)(CGSize itemSize, Class cellClass, id data))ylt_create {
    return ^id(CGSize itemSize, Class cellClass, id data) {
        YLT_CollectionRowModel *result = [[YLT_CollectionRowModel alloc] init];
        result.itemSize = itemSize;
        result.cellClass = cellClass;
        result.data = data;
        return result;
    };
}

@end
