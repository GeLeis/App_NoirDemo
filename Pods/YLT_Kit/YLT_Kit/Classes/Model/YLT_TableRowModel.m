//
//  PHTableRowModel.m
//  Pods
//
//  Created by 項普華 on 2017/8/20.
//
//

#import "YLT_TableRowModel.h"

@implementation YLT_TableRowModel

/**
 Cell 数据
 */
+ (YLT_TableRowModel *(^)(CGFloat rowHeight, Class cellClass, id data))ylt_create {
    return ^id(CGFloat rowHeight, Class cellClass, id data) {
        YLT_TableRowModel *result = [[YLT_TableRowModel alloc] init];
        result.rowHeight = rowHeight;
        result.cellClass = cellClass;
        result.data = data;
        return result;
    };
}


@end
