//
//  YLT_PageControl.h
//  App
//
//  Created by 項普華 on 2019/12/19.
//  Copyright © 2019 Alex. All rights reserved.
//

#import <YLT_Kit/YLT_Kit.h>

@interface YLT_PageControl : YLT_BaseView

/** 当前pageIndex */
@property (nonatomic, assign) NSInteger currentPageIndex;

/** 总数量 */
@property (nonatomic, assign) NSInteger totalPageCount;

/** 当前Page的颜色 */
@property (nonatomic, strong) UIColor *currentPageColor;

/** 普通状态颜色 */
@property (nonatomic, strong) UIColor *normalColor;

/** <#注释#> */
@property (nonatomic, assign) CGSize currentDotSize;

/** <#注释#> */
@property (nonatomic, assign) CGSize normalDotSize;

/** <#注释#> */
@property (nonatomic, assign) CGFloat spacing;

/** <#注释#> */
@property (nonatomic, copy) void(^currentPageDidChange)(NSInteger index);

@end
