//
//  UIView+YLT_Create.h
//  YLT_Kit
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface UIView (YLT_Create)

+ (UIView *(^)(void))ylt_create;
/**
 视图的创建
 */
+ (UIView *(^)(UIView *superView, void (^)(MASConstraintMaker *make)))ylt_createLayout;
/**
 视图的布局
 */
- (UIView *(^)(void (^)(MASConstraintMaker *make)))ylt_layout;
/**
 视图的创建frame
 */
+ (UIView *(^)(UIView *superView, CGRect frame))ylt_createFrame;
/**
 视图的创建frame
 */
- (UIView *(^)(CGRect frame))ylt_frame;
/**
 设置视图上的数据显示
 */
- (UIView *(^)(id data))ylt_data;
/**
 设置背景颜色
 */
- (UIView *(^)(UIColor *bgColor))ylt_backgroundColor;
/**
 设置圆角
 */
- (UIView *(^)(NSInteger radius))ylt_radius;
/**
 设置边框颜色
 */
- (UIView *(^)(UIColor *borderColor))ylt_borderColor;
/**
 设置边框宽度
 */
- (UIView *(^)(CGFloat borderWidth))ylt_borderWidth;
/**
 设置阴影颜色
 */
- (UIView *(^)(UIColor *shadowColor))ylt_shadowColor;
/**
 设置阴影的大小
 */
- (UIView *(^)(CGSize shadowOffset))ylt_shadowSize;
/**
 设置阴影模糊度
 */
- (UIView *(^)(CGFloat blur))ylt_blur;
/**
 设置tag
 */
- (UIView *(^)(NSInteger tag))ylt_tag;
/**
 设置透明度
 */
- (UIView *(^)(CGFloat alpha))ylt_alpha;
/**
 设置触摸是否可用
 */
- (UIView *(^)(BOOL userInteractionEnabled))ylt_userInteractionEnabled;
/**
 赋值
 */
- (UIView *(^)(UIView **target))ylt_target;
/**
 点击事件
 */
- (UIView *(^)(void (^)(id response)))ylt_clickBlock;
/**
 信号量
 */
- (UIView *(^)(RACSignal *signal))ylt_signal;

#pragma mark - type convert
- (UIButton *(^)(void))ylt_convertToButton;
- (UILabel *(^)(void))ylt_convertToLabel;
- (UIImageView *(^)(void))ylt_convertToImageView;
- (UITableView *(^)(void))ylt_convertToTableView;
- (UITextField *(^)(void))ylt_convertToTextField;
- (UICollectionView *(^)(void))ylt_convertToCollectionView;

#pragma mark - normal method

/**
 获取当前对象

 @return 当前对象
 */
- (id)ylt_self;
/**
 获取当前视图的中心点
 
 @return 中心点
 */
- (CGPoint)ylt_selfcenter;
/**
 获取当前view绑定的data
 
 @return data
 */
- (id)data;





@end
