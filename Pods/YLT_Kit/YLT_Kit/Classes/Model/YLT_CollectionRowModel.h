//
//  YLT_CollectionRowModel.h
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import <Foundation/Foundation.h>

@interface YLT_CollectionRowModel : NSObject

/**
 item Size
 */
@property (nonatomic, assign) CGSize itemSize;

/**
 cell class
 */
@property (nonatomic, strong) Class cellClass;

/**
 data
 */
@property (nonatomic, strong) id data;

/**
 cell 数据
 */
+ (YLT_CollectionRowModel *(^)(CGSize itemSize, Class cellClass, id data))ylt_create;

@end
