//
//  UIViewController+ylt_BaseVC.h
//  Test
//
//  Created by 项普华 on 2018/4/3.
//  Copyright © 2018年 项普华. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+YLT_BaseView.h"

@protocol HookBaseVCProtocol <NSObject>

@optional

#pragma mark - ViewDidLoad 中调用
/**
 Setup
 主要负责页面变量的初始化、页面元素的颜色等
 */
- (void)ylt_setup;

/**
 视图的页面配置
 主要负责视图的添加工作 以及约束的设置
 */
- (void)ylt_addSubViews;

/**
 网络请求
 主要负责当前页面的初始网络请求
 */
- (void)ylt_request;

#pragma mark - viewWillAppear 中调用
/**
 数据与视图的绑定
 主要负责数据与页面的绑定操作
 */
- (void)ylt_bindData;

#pragma mark - viewWillLayoutSubviews 中调用
/**
 页面的布局
 视图加载完成需要更新布局的操作
 */
- (void)ylt_layout;

#pragma mark - viewWillDisappear 中调用
/**
 页面消失的调用 注意只有 pop 或者 dismiss的时候才会调用
 当页面消失的时候的回调
 */
- (void)ylt_dismiss;

@end

@interface UIViewController (YLT_BaseVC)<HookBaseVCProtocol>

/**
 上一个页面传入的参数
 */
@property (nonatomic, strong) id ylt_params;

/**
 当前页面的操作队列，进入页面的时候会启动，离开页面时会挂起
 */
@property (nonatomic, strong, readonly) NSOperationQueue *ylt_queue;

/**
 页面回调
 */
@property (nonatomic, copy) void(^ylt_callback)(id response);

/**
 页面回调
 */
@property (nonatomic, copy) void(^ylt_completion)(NSError *error, id response);

/**
 push进页面

 @param vc 目标页面
 @param callback 回调
 */
- (void)ylt_pushToVC:(UIViewController *)vc callback:(void(^)(id response))callback;

/**
 push进页面
 
 @param vc 目标页面
 @param callback 回调
 */
- (void)ylt_presentToVC:(UIViewController *)vc callback:(void(^)(id response))callback;

/**
 创建控制器
 
 @return 控制器
 */
+ (UIViewController *)ylt_create;
/**
 创建控制器
 
 @return 控制器
 */
+ (UIViewController *)ylt_createVC;

/**
 快速创建控制器并传入参数
 
 @param ylt_param 参数
 @return 控制器
 */
+ (UIViewController *)ylt_createVCWithParam:(id)ylt_param;

/**
 快速创建控制器并传入参数
 
 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_createVCWithParam:(id)ylt_param
                                   callback:(void(^)(id response))callback;

/**
 创建视图并PUSH到对应的视图
 
 @param ylt_param 参数
 @return 控制器
 */
+ (UIViewController *)ylt_pushVCWithParam:(id)ylt_param;

/**
 创建视图并PUSH到对应的视图

 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_pushVCWithParam:(id)ylt_param
                                 callback:(void(^)(id response))callback;

/**
 创建控制器并Modal到对应的视图
 
 @param ylt_param 参数
 @return 控制器
 */
+ (UIViewController *)ylt_modalVCWithParam:(id)ylt_param;

/**
 创建控制器并Modal到对应的视图

 @param ylt_param 参数
 @param callback 回调
 @return 控制器
 */
+ (UIViewController *)ylt_modalVCWithParam:(id)ylt_param
                                  callback:(void(^)(id response))callback;

@end
