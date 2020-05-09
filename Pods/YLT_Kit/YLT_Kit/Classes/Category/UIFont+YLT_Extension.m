//
//  UIFont+YLT_Utils.m
//  YLT_Kit
//
//  Created by pz on 08/04/2018.
//

#import "UIFont+YLT_Extension.h"
#import "YLT_BaseMacro.h"

@implementation UIFont (YLT_Utils)
+ (UIFont *)ylt_mediumFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@"PingFangSC-Medium" fontSize:x];
}

+ (UIFont *)ylt_lightFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@"PingFangSC-Light" fontSize:x];
}

+ (UIFont *)ylt_semiboldFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@"PingFangSC-Semibold" fontSize:x];
}

+ (UIFont *)ylt_thinFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@"PingFangSC-Thin" fontSize:x];
}

+ (UIFont *)ylt_regularFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@"PingFangSC-Regular" fontSize:x];
}

+ (UIFont *)ylt_stRegularFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@"FZQingKeBenYueSongS-R-GB" fontSize:x];
}

+ (UIFont *)ylt_politicaBoldFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@"Politica-Bold" fontSize:x];
}

+ (UIFont *)ylt_sfBoldFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@".HelveticaNeueDeskInterface-Bold" fontSize:x];
}

+ (UIFont *)ylt_sfRegularFont:(CGFloat)x {
    return [self ylt_FontFamilyName:@".HelveticaNeueDeskInterface-Regular" fontSize:x];
}

+ (UIFont *)ylt_FontFamilyName:(NSString*)familyName fontSize:(CGFloat)fontSize {
    if (iOS9Later) {
        UIFont *font = [UIFont fontWithName:familyName size:fontSize];
        if (font) {
            return font;
        }
    }
    return [UIFont systemFontOfSize:fontSize];

}
@end
