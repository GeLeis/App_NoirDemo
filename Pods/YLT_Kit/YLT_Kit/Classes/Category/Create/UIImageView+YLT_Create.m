//
//  UIImageView+YLT_Create.m
//  Masonry
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UIImageView+YLT_Create.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <YLT_BaseLib/YLT_BaseLib.h>
#import "UIImage+YLT_Extension.h"
#import "UIView+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UIImageView (YLT_Create)

/**
 设置image
 */
- (UIImageView *(^)(id))ylt_image {
    @weakify(self);
    return ^id(id image) {
        @strongify(self);
        if ([self isKindOfClass:[UIImageView class]]) {
            if ([image isKindOfClass:[UIImage class]]) {
                [self setImage:image];
            } else if ([image isKindOfClass:[NSURL class]]) {
                [self setImageWithURL:(NSURL *)image];
            } else if ([image isKindOfClass:[NSString class]]) {
                if ([((NSString *)image) ylt_isURL]) {
                    [self setImageWithURL:[NSURL URLWithString:(NSString *)image]];
                } else {
                    [self setImage:[UIImage ylt_imageNamed:(NSString *)image]];
                }
            } else if ([image isKindOfClass:RACSignal.class]) {
                [((RACSignal *) image) subscribeNext:^(id  _Nullable x) {
                    @strongify(self);
                    self.ylt_image(x);
                }];
            }
        }
        return self;
    };
}

/**
 圆形图片
 */
- (UIImageView *(^)(id image))ylt_cirleImage {
    @weakify(self);
    return ^id(id image) {
        @strongify(self);
        if ([self isKindOfClass:[UIImageView class]]) {
            if ([image isKindOfClass:[UIImage class]]) {
                [self setImage:[image ylt_drawCircleImage]];
            } else if ([image isKindOfClass:[NSURL class]]) {
                [self sd_setImageWithURL:(NSURL *)image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    @strongify(self);
                    [self setImage:[image ylt_drawCircleImage]];
                }];
            } else if ([image isKindOfClass:[NSString class]]) {
                if ([((NSString *)image) ylt_isURL]) {
                    [self sd_setImageWithURL:(NSURL *)[NSURL URLWithString:(NSString *)image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        @strongify(self);
                        [self setImage:[image ylt_drawCircleImage]];
                    }];
                } else {
                    [self setImage:[[UIImage ylt_imageNamed:(NSString *)image] ylt_drawCircleImage]];
                }
            }
        }
        return self;
    };
}

/**
 圆角图片
 */
- (UIImageView *(^)(id image, CGFloat radius))ylt_rectImage {
    @weakify(self);
    return ^id(id image, CGFloat radius) {
        @strongify(self);
        if ([self isKindOfClass:[UIImageView class]]) {
            if ([image isKindOfClass:[UIImage class]]) {
                [self setImage:[image ylt_drawRectImage:radius]];
            } else if ([image isKindOfClass:[NSURL class]]) {
                [self sd_setImageWithURL:(NSURL *)image completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                    [self setImage:[image ylt_drawRectImage:radius]];
                }];
            } else if ([image isKindOfClass:[NSString class]]) {
                if ([((NSString *)image) ylt_isURL]) {
                    [self sd_setImageWithURL:(NSURL *)[NSURL URLWithString:(NSString *)image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
                        [self setImage:[image ylt_drawRectImage:radius]];
                    }];
                } else {
                    [self setImage:[[UIImage ylt_imageNamed:(NSString *)image] ylt_drawRectImage:radius]];
                }
            }
        }
        return self;
    };
}

/**
 设置显示方式
 */
- (UIImageView *(^)(UIViewContentMode contentMode))ylt_contentMode {
    @weakify(self);
    return ^id(UIViewContentMode contentMode) {
        @strongify(self);
        self.contentMode = contentMode;
        return self;
    };
}

/**
 信号量
 */
- (UIView *(^)(RACSignal *signal))ylt_signal {
    @weakify(self);
    return ^id(RACSignal *signal) {
        [signal subscribeNext:^(id  _Nullable x) {
            @strongify(self);
            self.ylt_image(x);
        }];
        return self;
    };
}

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
                         contentMode:(UIViewContentMode)contentMode {
    UIImageView *result = UIImageView
    .ylt_createLayout(superView, layout)
    .ylt_convertToImageView()
    .ylt_image(image)
    .ylt_contentMode(contentMode);
    return result;
}

@end
