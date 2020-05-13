//
//  UIImageView+Common.m
//  TableViewDemo
//
//  Created by gelei on 2020/5/8.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "UIImageView+Common.h"
#import <YLT_BaseLib/NSObject+YLT_Extension.h>
#import <UIImageView+WebCache.h>
#import <objc/runtime.h>

//是否黑白化,1表示开启
#define monochromatic 1

@implementation UIImageView (Common)

+ (void)load {
    [UIImageView ylt_swizzleInstanceMethod:@selector(gl_setImage:) withMethod:@selector(setImage:)];
}

- (void)gl_setImage:(UIImage *)image {
    if (monochromatic == 1) {
        [self gl_setImage:[self gl_grayImage:image]];
    } else {
        [self gl_setImage:image];
    }
}

- (UIImage *)gl_grayImage:(UIImage *)image {
    //滤镜处理
    //CIPhotoEffectNoir黑白
    //CIPhotoEffectMono单色
    NSString *filterName = @"CIPhotoEffectMono";
    CIFilter *filter = [CIFilter filterWithName:filterName];
    CIImage *inputImage = [[CIImage alloc] initWithImage:image];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    CGImageRef cgImage = [self.filterContext createCGImage:filter.outputImage fromRect:[inputImage extent]];
    UIImage *resultImg = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return resultImg;
}

- (CIContext *)filterContext {
    CIContext *con = objc_getAssociatedObject(self, @selector(filterContext));
    if (!con) {
        con = [[CIContext alloc] initWithOptions:nil];
        self.filterContext = con;
    }
    return con;
}

- (void)setFilterContext:(CIContext *)filterContext {
    objc_setAssociatedObject(self, @selector(filterContext), filterContext, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
