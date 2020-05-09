//
//  UIBarButtonItem+YTL_Utils.h
//  YLT_Kit
//
//  Created by pz on 08/04/2018.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (YLT_Extension)
/**
 是否显示红点角标
 */
@property (assign, nonatomic) BOOL hasBadge;

/**
 点击事件回调
 */
@property (nonatomic, copy) void(^ylt_clickBlock)(UIBarButtonItem *sender);

@end
