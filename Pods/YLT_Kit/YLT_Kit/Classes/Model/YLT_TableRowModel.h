//
//  PHTableRowModel.h
//  Pods
//
//  Created by 項普華 on 2017/8/20.
//
//

#import <Foundation/Foundation.h>

@interface YLT_TableRowModel : NSObject

/**
 行高
 */
@property (nonatomic, assign) CGFloat rowHeight;

/**
 cell class
 */
@property (nonatomic, strong) Class cellClass;

/**
 data
 */
@property (nonatomic, strong) id data;

/**
 Cell 数据
 */
+ (YLT_TableRowModel *(^)(CGFloat rowHeight, Class cellClass, id data))ylt_create;

@end
