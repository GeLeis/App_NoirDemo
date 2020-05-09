//
//  UIButton+YLT_Create.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

typedef NS_ENUM(NSUInteger, YLT_ButtonLayout) {
    YLT_ButtonLayoutImageAtLeft = 1,//图片在左边
    YLT_ButtonLayoutImageAtRight,//图片在右边
    YLT_ButtonLayoutImageAtTop,//图片在上边
    YLT_ButtonLayoutImageAtBottom,//图片在下边
};

@interface UIButton (YLT_Create)

/**
 普通image
 */
- (UIButton *(^)(id img))ylt_normarlImage;
/**
 普通title
 */
- (UIButton *(^)(NSString *title))ylt_normalTitle;
/**
 普通Color
 */
- (UIButton *(^)(UIColor *color))ylt_normalColor;
/**
 普通字号
 */
- (UIButton *(^)(CGFloat fontSize))ylt_fontSize;
/**
 普通字体
 */
- (UIButton *(^)(UIFont *font))ylt_font;
/**
 选中image
 */
- (UIButton *(^)(id img))ylt_selectedImage;
/**
 选中title
 */
- (UIButton *(^)(NSString *title))ylt_selectedTitle;
/**
 选中Color
 */
- (UIButton *(^)(UIColor *color))ylt_selectedColor;
/**
 高亮image
 */
- (UIButton *(^)(id img, UIControlState state))ylt_stateImage;
/**
 高亮title
 */
- (UIButton *(^)(NSString *title, UIControlState state))ylt_stateTitle;
/**
 高亮Color
 */
- (UIButton *(^)(UIColor *color, UIControlState state))ylt_stateColor;
/**
 设置按钮的状态
 */
- (UIButton *(^)(UIControlState state))ylt_state;
/**
 布局
 */
- (UIButton *(^)(YLT_ButtonLayout layout, CGFloat spacing))ylt_buttonLayout;
/**
 点击按钮的事件
 */
- (UIButton *(^)(void (^)(UIButton *response)))ylt_buttonClickBlock;





#pragma mark - 快速创建对象
/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局约束
 @param image 图片
 @param clickBlock 点击事件回调
 @return 当前对象
 */
+ (UIButton *)ylt_createSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            image:(id)image
                      clickAction:(void(^)(UIButton *response))clickBlock;

/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局
 @param title 标题
 @param clickBlock 点击事件回调
 @return 当前对象
 */
+ (UIButton *)ylt_createSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            title:(NSString *)title
                      clickAction:(void(^)(UIButton *response))clickBlock;

/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局
 @param image 图像
 @param title 标题
 @param buttonLayout button上图像与标题的布局
 @param clickBlock 点击事件的回调
 @return 当前对象
 */
+ (UIButton *)ylt_createSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            image:(id)image
                            title:(NSString *)title
                     buttonLayout:(YLT_ButtonLayout)buttonLayout
                      clickAction:(void(^)(UIButton *response))clickBlock;

+ (UIButton *)ylt_createSuperView:(UIView *)superView
                     buttonLayout:(YLT_ButtonLayout)buttonLayout
                            image:(UIImage *)image
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor
                            title:(NSString *)title
                          spacing:(CGFloat)spacing;

@end
