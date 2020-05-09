//
//  UINavigationController+YLT_Extension.m
//  BlackCard
//
//  Created by youye on 2018/4/11.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "UINavigationController+YLT_Extension.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation UINavigationController (YLT_Extension)

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self ylt_swizzleInstanceMethod:@selector(popViewControllerAnimated:) withMethod:@selector(ylt_popViewControllerAnimated:)];
//        [self ylt_swizzleInstanceMethod:@selector(pushViewController:animated:) withMethod:@selector(ylt_pushViewController:animated:)];
//        [self ylt_swizzleInstanceMethod:@selector(popToRootViewControllerAnimated:) withMethod:@selector(ylt_popToRootViewControllerAnimated:)];
//        [self ylt_swizzleInstanceMethod:@selector(popToViewController:animated:) withMethod:@selector(ylt_popToViewController:animated:)];
//    });
}

//- (nullable NSArray<__kindof UIViewController *> *)ylt_popToViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.ylt_prohibitPushPop)
//        return nil;
//    if (animated) {
//        self.ylt_prohibitPushPop = YES;
//    }
//
//    NSArray *viewControllers = [self ylt_popToViewController:viewController animated:animated];
//    if (viewControllers.count == 0) {
//        self.ylt_prohibitPushPop = NO;
//    }
//
//    return viewControllers;
//}
//
//- (nullable NSArray<__kindof UIViewController *> *)ylt_popToRootViewControllerAnimated:(BOOL)animated {
//    if (self.ylt_prohibitPushPop) {
//        return nil;
//    }
//    if (animated) {
//        self.ylt_prohibitPushPop = YES;
//    }
//    NSArray *viewControllers = [self ylt_popToRootViewControllerAnimated:animated];
//    if (viewControllers.count == 0) {
//        self.ylt_prohibitPushPop = NO;
//    }
//    return viewControllers;
//}
//
//- (void)ylt_pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
//    if (self.ylt_prohibitPushPop) {
//        return;
//    }
//
//    [self ylt_pushViewController:viewController animated:animated];
//    if (animated) {
//        self.ylt_prohibitPushPop = YES;
//    }
//}
//
//- (nullable UIViewController *)ylt_popViewControllerAnimated:(BOOL)animated {
//    if (self.ylt_prohibitPushPop) {
//        return nil;
//    }
//    if (animated) {
//        self.ylt_prohibitPushPop = YES;
//    }
//    UIViewController *vc = [self ylt_popViewControllerAnimated:animated];
//
//    if (vc == nil) {
//        self.ylt_prohibitPushPop = NO;
//    }
//    return vc;
//}
//
//- (BOOL)ylt_prohibitPushPop {
//    return [objc_getAssociatedObject(self, @selector(ylt_prohibitPushPop)) boolValue];
//}
//
//- (void)setYlt_prohibitPushPop:(BOOL)ylt_prohibitPushPop {
//    objc_setAssociatedObject(self, @selector(ylt_prohibitPushPop), @(ylt_prohibitPushPop), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//}

/**
 寻找Navigation中的某个viewControler对象
 
 @param className viewControler名称
 @return viewControler对象
 */
- (id)ylt_findViewController:(NSString *)className {
    for (UIViewController *viewController in self.viewControllers) {
        if ([viewController isKindOfClass:NSClassFromString(className)]) {
            return viewController;
        }
    }
    return nil;
}

/**
 判断是否只有一个RootViewController
 
 @return 是否只有一个RootViewController
 */
- (BOOL)ylt_isOnlyContainRootViewController {
    if (self.viewControllers &&
        self.viewControllers.count == 1) {
        return YES;
    }
    return NO;
}

/**
 viewControllers.firstObject
 
 @return RootViewController
 */
- (UIViewController *)ylt_rootViewController {
    if (self.viewControllers && [self.viewControllers count] >0) {
        return [self.viewControllers firstObject];
    }
    return nil;
}

/**
 返回指定的viewControler
 
 @param className 指定viewControler类名
 @param animated 是否动画
 @return pop之后的viewControlers
 */
- (NSArray *)ylt_popToViewControllerWithClassName:(NSString *)className animated:(BOOL)animated {
    return [self popToViewController:[self ylt_findViewController:className] animated:YES];
}

/**
 返回指定的viewControler n层
 
 @param level n层
 @param animated 是否动画
 @return pop之后的viewControlers
 */
- (NSArray *)ylt_popToViewControllerWithLevel:(NSInteger)level animated:(BOOL)animated {
    NSInteger viewControllersCount = self.viewControllers.count;
    if (viewControllersCount > level) {
        NSInteger idx = viewControllersCount - level - 1;
        UIViewController *viewController = self.viewControllers[idx];
        return [self popToViewController:viewController animated:animated];
    } else {
        return [self popToRootViewControllerAnimated:animated];
    }
}

@end



@implementation UIViewController (YLT_NavigationExtension)

//+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [self ylt_swizzleInstanceMethod:@selector(viewWillAppear:) withMethod:@selector(ylt_navigation_viewWillAppear:)];
//    });
//}
//
//- (void)ylt_navigation_viewWillAppear:(BOOL)animated {
//    [self ylt_navigation_viewWillAppear:animated];
//}

@end
