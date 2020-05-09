//
//  UIFont+YLT_Utils.h
//  YLT_Kit
//
//  Created by pz on 08/04/2018.
//

#import <UIKit/UIKit.h>

@interface UIFont (YLT_Utils)

+ (UIFont *)ylt_mediumFont:(CGFloat)x;
+ (UIFont *)ylt_lightFont:(CGFloat)x;
+ (UIFont *)ylt_semiboldFont:(CGFloat)x;
+ (UIFont *)ylt_thinFont:(CGFloat)x;
+ (UIFont *)ylt_regularFont:(CGFloat)x;
+ (UIFont *)ylt_stRegularFont:(CGFloat)x;
+ (UIFont *)ylt_politicaBoldFont:(CGFloat)x;
+ (UIFont *)ylt_sfBoldFont:(CGFloat)x;
+ (UIFont *)ylt_sfRegularFont:(CGFloat)x;
+ (UIFont *)ylt_FontFamilyName:(NSString*)familyName fontSize:(CGFloat)fontSize;

@end
