//
//  UIColor+YLT_Extension.h
//  AFNetworking
//
//  Created by YLT_Alex on 2018/2/12.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM (NSUInteger, UIGradientStyle) {
    YLT_UIGradientStyleLeftToRight,
    YLT_UIGradientStyleRadial,
    YLT_UIGradientStyleTopToBottom,
    YLT_UIGradientStyleTriangle
};

@interface UIColor (YLT_Extension)

/**
 颜色模式
 */
@property (nonatomic, readonly) CGColorSpaceModel ylt_colorSpaceModel;
@property (nonatomic, readonly) BOOL ylt_canProvideRGBComponents;
@property (nonatomic, readonly) CGFloat ylt_red; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat ylt_green; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat ylt_blue; // Only valid if canProvideRGBComponents is YES
@property (nonatomic, readonly) CGFloat ylt_white; // Only valid if colorSpaceModel == kCGColorSpaceModelMonochrome
@property (nonatomic, readonly) CGFloat ylt_alpha;
@property (nonatomic, readonly) UInt32 ylt_rgbHex;

/**
 获取颜色模式，比如rgb
 
 @return 对映字符串
 */
- (NSString *)ylt_colorSpaceString;

/**
 RGBA模式的，r,g,b,a number值
 
 @return numbers
 */
- (NSArray *)ylt_arrayFromRGBAComponents;

/**
 变暗
 
 @return 颜色
 */
- (UIColor *)ylt_colorByLuminanceMapping;

/**
 相乘颜色混合
 
 @param red r
 @param green g
 @param blue b
 @param alpha a
 @return 颜色
 */
- (UIColor *)ylt_colorByMultiplyingByRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 相加颜色混合
 
 @param red r
 @param green g
 @param blue b
 @param alpha a
 @return 颜色
 */
- (UIColor *)ylt_colorByAddingRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 采用最亮的
 
 @param red r
 @param green g
 @param blue b
 @param alpha a
 @return 颜色
 */
- (UIColor *)ylt_colorByLighteningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 采用最暗的
 
 @param red r
 @param green g
 @param blue b
 @param alpha a
 @return 颜色
 */
- (UIColor *)ylt_colorByDarkeningToRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;

/**
 乘以当前系数
 
 @param f 系数
 @return 颜色
 */
- (UIColor *)ylt_colorByMultiplyingBy:(CGFloat)f;

/**
 增加当前系数
 
 @param f 系数
 @return 颜色
 */
- (UIColor *)ylt_colorByAdding:(CGFloat)f;

/**
 变亮为当前色,a为0
 
 @param f 当前系数
 @return 颜色
 */
- (UIColor *)ylt_colorByLighteningTo:(CGFloat)f;

/**
 变暗为当前色,a为1
 
 @param f 当前系数
 @return 颜色
 */
- (UIColor *)ylt_colorByDarkeningTo:(CGFloat)f;

- (UIColor *)ylt_colorByMultiplyingByColor:(UIColor *)color;
- (UIColor *)ylt_colorByAddingColor:(UIColor *)color;
- (UIColor *)ylt_colorByLighteningToColor:(UIColor *)color;
- (UIColor *)ylt_colorByDarkeningToColor:(UIColor *)color;

/**
 获取当前颜色字符串
 
 @return 颜色字符串
 */
- (NSString *)ylt_stringFromColor;
/**
 获取当前颜色十六进制
 
 @return 十六进制字符串
 */
- (NSString *)ylt_hexStringFromColor;

/**
 根据{}颜色字符串，转颜色
 
 @param stringToConvert 字符串
 @return 颜色
 */
+ (UIColor *)ylt_colorWithString:(NSString *)stringToConvert;

/**
 随机色
 
 @return 颜色
 */
+ (UIColor *)ylt_randomColor;

/**
 16进制整数转颜色
 
 @param hex 十六进制整数
 @return 颜色
 */
+ (UIColor *)ylt_colorWithRGBHex:(UInt32)hex;

/**
 16进制字符串转颜色
 
 @param stringToConvert 十六进制字符串
 @return 颜色
 */
+ (UIColor *)ylt_colorWithHexString:(NSString *)stringToConvert;

/**
 16进制字符串转颜色
 
 @param stringToConvert 十六进制字符串
 @param alpha 透明度
 @return 颜色
 */
+ (UIColor *)ylt_colorWithHexString:(NSString *)stringToConvert andAlpha:(CGFloat)alpha;

//渐变背景色
/**
 创建指定大小的渐变色背景
 
 @param gradientStyle 渐变方向
 @param frame 尺寸
 @param colors 渐变色
 @return 颜色
 */
+ (UIColor *)ylt_colorWithGradientStyle:(UIGradientStyle)gradientStyle withFrame:(CGRect)frame andColors:(NSArray<UIColor *> * _Nonnull)colors;

/**
 创建指定大小的渐变色，locations可以指定
 
 @param gradientStyle 渐变方向
 @param frame 指定大小
 @param colors 渐变色
 @param c_locations 渐变色
 @return 颜色
 */
+ (UIColor *)ylt_colorWithGradientStyle:(UIGradientStyle)gradientStyle withFrame:(CGRect)frame andColors:(NSArray<UIColor *> * _Nonnull)colors locations:(NSArray *)c_locations;

@end
