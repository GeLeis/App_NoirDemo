//
//  UIColor+Common.m
//  TableViewDemo
//
//  Created by gelei on 2020/5/7.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "UIColor+Common.h"
#import <YLT_BaseLib/NSObject+YLT_Extension.h>
#import <Aspects.h>

//是否黑白化,1表示开启
#define monochromatic 1

@implementation UIColor (Common)

+ (void)load {
    //关键方法交换
    [UIColor ylt_swizzleClassMethod:@selector(gl_colorWithRed:green:blue:alpha:) withMethod:@selector(colorWithRed:green:blue:alpha:)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_blackColor) withMethod:@selector(blackColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_darkGrayColor) withMethod:@selector(darkGrayColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_lightGrayColor) withMethod:@selector(lightGrayColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_whiteColor) withMethod:@selector(whiteColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_grayColor) withMethod:@selector(grayColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_redColor) withMethod:@selector(redColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_greenColor) withMethod:@selector(greenColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_blueColor) withMethod:@selector(blueColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_cyanColor) withMethod:@selector(cyanColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_yellowColor) withMethod:@selector(yellowColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_magentaColor) withMethod:@selector(magentaColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_orangeColor) withMethod:@selector(orangeColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_purpleColor) withMethod:@selector(purpleColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_brownColor) withMethod:@selector(brownColor)];
    [UIColor ylt_swizzleClassMethod:@selector(gl_colorWithWhite:alpha:) withMethod:@selector(colorWithWhite:alpha:)];
    Class cls = NSClassFromString(@"UIDynamicSystemColor");
    [cls ylt_swizzleInstanceMethod:NSSelectorFromString(@"initWithName:colorsByThemeKey:") withMethod:@selector(gl_initWithName:colorsByThemeKey:)];
}

- (id)gl_initWithName:(id)name colorsByThemeKey:(id)key {
//    NSLog(@"name=%@  key =%@ ",name,key);
    if (monochromatic == 1) {
        if ([name isEqualToString:@"systemBlueColor"]) {
//                [UIColor systemBlueColor];
            return [UIColor blueColor];
        }
    }
   return [self gl_initWithName:name colorsByThemeKey:key];
}

+ (UIColor *)gl_colorWithRed:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha {
    //如果是单色模式(黑白模式),则平均r、g、b值
    if (monochromatic == 1) {
        //r,g,b权重调整,防止出现,1 0 0 、0 1 0,0 0 1同样的结果
        //0.2126，0.7152，0.0722 这三个是根据人眼对r,g,b三个颜色面感的强弱算出来的
        CGFloat brightness = (red * 0.2126 + 0.7152 * green + 0.0722 * blue);
//        CGFloat brightness = (red + green + blue) / 3.f;
        return [self gl_colorWithRed:brightness green:brightness blue:brightness alpha:alpha];
    }
    return [self gl_colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (UIColor *)gl_colorWithWhite:(CGFloat)white alpha:(CGFloat)alpha {
    return [self colorWithRed:white green:white blue:white alpha:1];
}

+ (UIColor *)gl_blackColor {
    return [self colorWithWhite:0 alpha:1];
}

+ (UIColor *)gl_darkGrayColor {
    return [self colorWithWhite:0.333 alpha:1];
}

+ (UIColor *)gl_lightGrayColor {
    return [self colorWithWhite:0.667 alpha:1];
}

+ (UIColor *)gl_whiteColor {
    return [self colorWithWhite:1 alpha:1];
}

+ (UIColor *)gl_grayColor {
    return [self colorWithWhite:0.5 alpha:1];
}

+ (UIColor *)gl_redColor {
    return [self colorWithRed:1 green:0 blue:0 alpha:1];
}

+ (UIColor *)gl_greenColor {
    return [self colorWithRed:0 green:1 blue:0 alpha:1];
}
+ (UIColor *)gl_blueColor {
    return [self colorWithRed:0 green:0 blue:1 alpha:1];
}
+ (UIColor *)gl_cyanColor {
    return [self colorWithRed:0 green:1 blue:1 alpha:1];
}
+ (UIColor *)gl_yellowColor {
    return [self colorWithRed:1 green:1 blue:0 alpha:1];
}
+ (UIColor *)gl_magentaColor {
    return [self colorWithRed:1 green:0 blue:1 alpha:1];
}
+ (UIColor *)gl_orangeColor {
    return [self colorWithRed:1 green:0.5 blue:0 alpha:1];
}
+ (UIColor *)gl_purpleColor {
    return [self colorWithRed:0.5 green:0 blue:0.5 alpha:1];
}
+ (UIColor *)gl_brownColor {
    return [self colorWithRed:0.6 green:0.4 blue:0.2 alpha:1];
}

@end
