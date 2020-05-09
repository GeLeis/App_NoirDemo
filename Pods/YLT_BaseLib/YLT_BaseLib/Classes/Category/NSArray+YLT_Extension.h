//
//  NSArray+YLT_Extension.h
//  YLT_BaseLib
//
//  Created by Alex on 2020/2/8.
//

#import <Foundation/Foundation.h>
#import "YLT_BaseModel.h"

@interface NSArray (YLT_Extension)

/** 数组元素的选中的索引 */
@property (nonatomic, assign) NSInteger ylt_selectedIndex;
/** 数组中选中的元素 */
@property (nonatomic, strong, readonly) id ylt_selectedObject;

@end
