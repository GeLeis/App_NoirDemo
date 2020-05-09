//
//  UIImageView+YLT_Create.h
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>

@interface UIImageView (YLT_Create)

/**
 设置image
 */
- (UIImageView *(^)(id image))ylt_image;
/**
 圆形图片
 */
- (UIImageView *(^)(id image))ylt_cirleImage;
/**
 圆角图片
 */
- (UIImageView *(^)(id image, CGFloat radius))ylt_rectImage;
/**
 设置显示方式
 */
- (UIImageView *(^)(UIViewContentMode contentMode))ylt_contentMode;

#pragma mark - 快速创建对象
/**
 快速创建对象
 
 @param superView 父视图
 @param layout 布局约束
 @param image image
 @param contentMode contentMode
 @return 当前对象
 */
+ (UIImageView *)ylt_createSuperView:(UIView *)superView
                              layout:(void(^)(MASConstraintMaker *make))layout
                               image:(id)image
                         contentMode:(UIViewContentMode)contentMode;

@end
