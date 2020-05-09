//
//  UINavigationController+YLT_Extension.h
//  BlackCard
//
//  Created by youye on 2018/4/11.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINavigationController (YLT_Extension)

/**
 寻找Navigation中的某个viewControler对象

 @param className viewControler名称
 @return viewControler对象
 */
- (id)ylt_findViewController:(NSString *)className;

/**
 判断是否只有一个RootViewController

 @return 是否只有一个RootViewController
 */
- (BOOL)ylt_isOnlyContainRootViewController;

/**
 viewControllers.firstObject

 @return RootViewController
 */
- (UIViewController *)ylt_rootViewController;

/**
 返回指定的viewControler

 @param className 指定viewControler类名
 @param animated 是否动画
 @return pop之后的viewControlers
 */
- (NSArray *)ylt_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated;

/**
 返回指定的viewControler n层

 @param level n层
 @param animated 是否动画
 @return pop之后的viewControlers
 */
- (NSArray *)ylt_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated;

@end
