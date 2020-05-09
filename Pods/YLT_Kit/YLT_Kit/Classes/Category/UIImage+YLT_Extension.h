//
//  UIImage+YLT_Extension.h
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import <UIKit/UIKit.h>
@class ALAsset;

@interface UIImage (YLT_Extension)

/**
 改变图片的显示色调、明暗等
 
 @param hue 色调   用角度度量，取值范围为 0～255
 @param saturation 饱和度  取值范围为 0～1 值越大，颜色越饱和
 @param bright 透明度  通常取值范围为  0（黑）到 1（白）
 @return 改变后的图片
 */
- (UIImage *)ylt_imageWithHue:(CGFloat)hue saturation:(CGFloat)saturation bright:(CGFloat)bright;

/**
 通过颜色获取纯色的图片
 
 @param color 颜色
 @return 图片
 */
+ (UIImage *)ylt_imageWithColor:(UIColor *)color;

/**
 通过颜色,尺寸获取纯色的图片
 
 @param aColor 颜色
 @param aFrame 尺寸
 @return 图片
 */
+ (UIImage *)ylt_imageWithColor:(UIColor *)aColor withFrame:(CGRect)aFrame;

/**
 渲染纯色图片颜色，比如将白色箭头渲染成黑色箭头
 
 @param color 目标颜色
 @return 图片
 */
- (UIImage *)ylt_renderColor:(UIColor *)color;

/**
 读取Image
 
 @param imageName image的路径或名字
 @return 图片
 */
+ (UIImage *)ylt_imageNamed:(NSString *)imageName;

/**
 绘制圆角图片
 
 @return 圆形图片
 */
- (UIImage *)ylt_drawCircleImage;

/**
 绘制圆角
 
 @param radius 圆角
 @return 圆角图
 */
- (UIImage *)ylt_drawRectImage:(CGFloat)radius;

/**
 压缩到指定大小size
 
 @param size 目标size
 @return 压缩图
 */
- (UIImage *)ylt_scaledToSize:(CGSize)size;

/**
 压缩最大边框为 maxLength 的图片
 
 @param maxLength 最大的边长
 @return 压缩图
 */
- (UIImage *)ylt_scaledToMaxLength:(CGFloat)maxLength;

/**
 压缩到指定大小size,并保证图片清晰度和质量好于上面方法
 
 @param size 目标size
 @param highQuality 是否保证质量
 @return 压缩图
 */
- (UIImage *)ylt_scaledToSize:(CGSize)size highQuality:(BOOL)highQuality;

/**
 修正图片方向
 
 @param aImage 原图
 @return 修正图
 */
+ (UIImage *)ylt_fixOrientation:(UIImage *)aImage;

/**
 获取视频的帧图
 
 @param videoURL 视频url
 @return 视频帧图
 */
+ (UIImage *) ylt_thumbnailImageForVideo:(NSURL *)videoURL;

/**
 获取原图
 
 @param asset 资源
 @return 图片
 */
+ (UIImage *)ylt_fullResolutionImageFromALAsset:(ALAsset *)asset;

/**
 获取调整后的全屏图
 
 @param asset 资源
 @return 图片
 */
+ (UIImage *)ylt_fullScreenImageALAsset:(ALAsset *)asset;

/**
 获取当前屏幕
 
 @return 屏幕快照
 */
+ (UIImage *)ylt_screenshotImage;

/**
 将某个视图转换成图片
 
 @param view 视图
 @return 图片
 */
+ (UIImage *)ylt_convertViewToImage:(UIView *)view;

/**
 返回图片在某个坐标点的像素颜色
 
 @param point 坐标点
 @return 颜色
 */
- (UIColor *)ylt_colorAtPixel:(CGPoint)point;

/**
 图片的默认优化算法
 
 @return 优化后的图片，返回的一定是JPEG格式的 最大控制在512KB范围内
 */
- (UIImage *)ylt_representation;

/**
 获取图片的类型
 
 @param imageData 图片数据
 @return 类型名称 PNG、JPEG等
 */
+ (NSString *)ylt_imageTypeFromData:(NSData *)imageData;

/**
 图片压缩算法处理
 
 @param imageData 图片压缩前的数据
 @param kb 大小
 @return 压缩后的Data
 */
+ (NSData *)ylt_representationData:(NSData *)imageData kb:(NSUInteger)kb;

/**
 图片压缩算法处理
 
 @param image 图片压缩前的数据
 @param kb 大小
 @return 压缩后的Data
 */
+ (NSData *)ylt_representationImage:(UIImage *)image kb:(NSUInteger)kb;

/**
 *  压图片大小
 *
 *  @param originImage  原图
 *  @param maxLength 最长边
 *
 *  @return image
 */
+ (UIImage *)ylt_representationImageSizeWithImage:(UIImage *)originImage maxLength:(CGFloat)maxLength;

/**
 *  压图片大小和质量
 *
 *  @param originImage 图片源
 *  @param maxLength 最大宽高限制
 *  @param maxKB 最大质量限制
 *
 *  @return data
 */
+ (NSData *)ylt_representationImageSizeAndQualityWithImage:(UIImage *)originImage maxLength:(NSInteger)maxLength maxKB:(NSInteger)maxKB;

/**
 裁剪图片
 
 @param rect 裁剪区域
 @return 裁剪后图片
 */
- (UIImage *)ylt_cropImageWithRect:(CGRect)rect;

/**
 gif图转换为图片

 @param data
 @return 转换后的图片资源数组
 */
+ (NSArray <UIImage *>*)imgArrFromGif:(NSData *)data;

/// 旋转图片
/// @param orient 方向
- (UIImage *)ylt_rotate:(UIImageOrientation)orient;

/**
 旋转自定义角度

 @param angle 角度
 @return 图片
 */
- (UIImage *)ylt_imageAngle:(CGFloat)angle;

@end
