//
//  UIButton+YLT_Create.m
//  Pods
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UIButton+YLT_Create.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import "UIView+YLT_Create.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <AFNetworking/UIButton+AFNetworking.h>
#import "UIImage+YLT_Extension.h"
#import <objc/message.h>

#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wincomplete-implementation"

@interface UIButton (YLT_CreateData)

/** <#注释#> */
@property (nonatomic, strong) UIView *ylt_contentView;

/** <#注释#> */
@property (nonatomic, strong) UIImageView *ylt_imageView;

/** <#注释#> */
@property (nonatomic, strong) UILabel *ylt_titleLabel;

@end


@implementation UIButton (YLT_Create)
/**
 普通image
 */
- (UIButton *(^)(id img))ylt_normarlImage {
    @weakify(self);
    return ^id(id image) {
        @strongify(self);
        return self.ylt_stateImage(image, UIControlStateNormal);
    };
}
/**
 普通title
 */
- (UIButton *(^)(NSString *title))ylt_normalTitle {
    @weakify(self);
    return ^id(NSString *title) {
        @strongify(self);
        return self.ylt_stateTitle(title, UIControlStateNormal);
    };
}
/**
 普通Color
 */
- (UIButton *(^)(UIColor *color))ylt_normalColor {
    @weakify(self);
    return ^id(UIColor *color) {
        @strongify(self);
        return self.ylt_stateColor(color, UIControlStateNormal);
    };
}
/**
 普通字号
 */
- (UIButton *(^)(CGFloat fontSize))ylt_fontSize {
    @weakify(self);
    return ^id(CGFloat fontSize) {
        @strongify(self);
        self.titleLabel.font = [UIFont systemFontOfSize:fontSize];
        return self;
    };
}
/**
 普通字体
 */
- (UIButton *(^)(UIFont *font))ylt_font {
    @weakify(self);
    return ^id(UIFont *font) {
        @strongify(self);
        self.titleLabel.font = font;
        return self;
    };
}
/**
 选中image
 */
- (UIButton *(^)(id img))ylt_selectedImage {
    @weakify(self);
    return ^id(id img) {
        @strongify(self);
        return self.ylt_stateImage(img, UIControlStateSelected);
    };
}
/**
 选中title
 */
- (UIButton *(^)(NSString *title))ylt_selectedTitle {
    @weakify(self);
    return ^id(NSString *title) {
        @strongify(self);
        return self.ylt_stateTitle(title, UIControlStateSelected);
    };
}
/**
 选中Color
 */
- (UIButton *(^)(UIColor *color))ylt_selectedColor {
    @weakify(self);
    return ^id(UIColor *color) {
        @strongify(self);
        return self.ylt_stateColor(color, UIControlStateSelected);
    };
}
/**
 高亮image
 */
- (UIButton *(^)(id img, UIControlState state))ylt_stateImage {
    @weakify(self);
    return ^id(id img, UIControlState state) {
        @strongify(self);
        if ([self isKindOfClass:[UIButton class]]) {
            if ([img isKindOfClass:[UIImage class]]) {
                [self setImage:img forState:state];
            } else if ([img isKindOfClass:[NSURL class]]) {
                [self setImageForState:state withURL:img];
            } else if ([img isKindOfClass:[NSString class]]) {
                if ([((NSString *)(img)) ylt_isURL]) {
                    [self setImageForState:state withURL:[NSURL URLWithString:img]];
                } else {
                    [self setImage:[UIImage ylt_imageNamed:img] forState:state];
                }
            }
            [self setContentMode:UIViewContentModeScaleAspectFit];
            self.imageView.contentMode = UIViewContentModeScaleAspectFit;
        }
        return self;
    };
}
/**
 高亮title
 */
- (UIButton *(^)(NSString *title, UIControlState state))ylt_stateTitle {
    @weakify(self);
    return ^id(NSString *title, UIControlState state) {
        @strongify(self);
        if ([self isKindOfClass:[UIButton class]]) {
            [self setTitle:title forState:state];
        }
        return self;
    };
}
/**
 高亮Color
 */
- (UIButton *(^)(UIColor *color, UIControlState state))ylt_stateColor {
    @weakify(self);
    return ^id(UIColor *color, UIControlState state) {
        @strongify(self);
        if ([self isKindOfClass:[UIButton class]]) {
            [self setTitleColor:color forState:state];
        }
        return self;
    };
}

/**
 设置按钮的状态
 */
- (UIButton *(^)(UIControlState state))ylt_state {
    @weakify(self);
    return ^id(UIControlState state) {
        @strongify(self);
        switch (state) {
            case UIControlStateHighlighted: self.highlighted = YES; break;
            case UIControlStateDisabled: self.enabled = YES; break;
            case UIControlStateSelected: self.selected = YES; break;
            default:
                break;
        }
        return self;
    };
}

/**
 布局
 */
- (UIButton *(^)(YLT_ButtonLayout layout, CGFloat spacing))ylt_buttonLayout {
    @weakify(self);
    return ^id(YLT_ButtonLayout layout, CGFloat spacing) {
        @strongify(self);
//        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            obj.hidden = YES;
//        }];
        [self layoutIfNeeded];
        CGSize size = [self.currentTitle sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];
        self.ylt_contentView.userInteractionEnabled = NO;
        self.ylt_contentView.backgroundColor = UIColor.clearColor;
        [self addSubview:self.ylt_contentView];
        
        self.ylt_imageView.contentMode = UIViewContentModeScaleAspectFit;
        [self.ylt_contentView addSubview:self.ylt_titleLabel];
        
        CGFloat width = 0;
        CGFloat height = 0;
        UIImage *image = self.currentImage;
        
        switch (layout) {
            case YLT_ButtonLayoutImageAtTop: {
                [self.ylt_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.centerX.equalTo(self.ylt_contentView);
                }];
                [self.ylt_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.centerX.equalTo(self.ylt_contentView);
                }];
                height = size.height + image.size.height + spacing;
                width = (size.width > image.size.width) ? size.width : image.size.width;
            }
                break;
            case YLT_ButtonLayoutImageAtBottom: {
                [self.ylt_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.bottom.centerX.equalTo(self.ylt_contentView);
                }];
                [self.ylt_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.top.centerX.equalTo(self.ylt_contentView);
                }];
                height = size.height + image.size.height + spacing;
                width = (size.width > image.size.width) ? size.width : image.size.width;
            }
                break;
            case YLT_ButtonLayoutImageAtLeft: {
                [self.ylt_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.centerY.equalTo(self.ylt_contentView);
                }];
                [self.ylt_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.centerY.equalTo(self.ylt_contentView);
                }];
                width = size.width + image.size.width + spacing;
                height = (size.height > image.size.height) ? size.height : image.size.height;
            }
                break;
            case YLT_ButtonLayoutImageAtRight: {
                [self.ylt_imageView mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.right.centerY.equalTo(self.ylt_contentView);
                }];
                [self.ylt_titleLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
                    make.left.centerY.equalTo(self.ylt_contentView);
                }];
                width = size.width + image.size.width + spacing;
                height = (size.height > image.size.height) ? size.height : image.size.height;
            }
                break;
        }
        [self.ylt_contentView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.size.mas_equalTo(CGSizeMake(width, height));
        }];
        self.ylt_imageView.image = self.currentImage;
        self.ylt_titleLabel.text = self.currentTitle;
        self.ylt_titleLabel.font = self.titleLabel.font;
        self.ylt_titleLabel.textColor = self.titleLabel.textColor;
        
        [self setImage:nil forState:UIControlStateNormal];
        self.ylt_normalTitle(@"");
        self.frame = CGRectMake(0, 0, width, height);
        [self layoutIfNeeded];
        return self;
    };
}


/**
 点击按钮的事件
 */
- (UIButton *(^)(void(^)(UIButton *response)))ylt_buttonClickBlock {
    @weakify(self);
    return ^id(void(^clickBlock)(UIButton *response)) {
        @strongify(self);
        [[self rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
            if (clickBlock) {
                clickBlock(x);
            }
        }];
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
            YLT_Log(@"%@", x);
        }];
        return self;
    };
}

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
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .ylt_createLayout(superView, layout)
    .ylt_convertToButton()
    .ylt_normarlImage(image)
    .ylt_clickBlock(clickBlock);
    return result;
}

/**
 快速创建Button
 
 @param superView 父视图
 @param layout 布局
 @param title 标题
 @param clickBLock 点击事件回调
 @return 当前对象
 */
+ (UIButton *)ylt_createSuperView:(UIView *)superView
                           layout:(void(^)(MASConstraintMaker *make))layout
                            title:(NSString *)title
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .ylt_createLayout(superView, layout)
    .ylt_convertToButton()
    .ylt_normalTitle(title)
    .ylt_normalColor([@"0x515151" ylt_colorFromHexString])
    .ylt_clickBlock(clickBlock);

    return result;
}

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
                      clickAction:(void(^)(UIButton *response))clickBlock {
    UIButton *result = (UIButton *)UIButton
    .ylt_createLayout(superView, layout)
    .ylt_convertToButton()
    .ylt_normalTitle(title)
    .ylt_normarlImage(image)
    .ylt_normalColor([@"0x515151" ylt_colorFromHexString])
    .ylt_buttonLayout(buttonLayout, 4)
    .ylt_clickBlock(clickBlock);
    
    return result;
}

+ (UIButton *)ylt_createSuperView:(UIView *)superView
                     buttonLayout:(YLT_ButtonLayout)buttonLayout
                            image:(UIImage *)image
                             font:(UIFont *)font
                        textColor:(UIColor *)textColor
                            title:(NSString *)title
                          spacing:(CGFloat)spacing {
    UIButton *result = [UIButton buttonWithType:UIButtonTypeCustom];
    result.ylt_normarlImage(image);
    result.ylt_font(font);
    result.ylt_normalColor(textColor);
    result.ylt_normalTitle(title);
    result.ylt_buttonLayout(buttonLayout, spacing);
    [superView addSubview:result];
    return result;
}

- (UIView *)ylt_contentView {
    UIView *result = objc_getAssociatedObject(self, @selector(ylt_contentView));
    if (result == nil) {
        result = [[UIView alloc] init];
        objc_setAssociatedObject(self, @selector(ylt_contentView), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [result addSubview:self.ylt_imageView];
        [result addSubview:self.ylt_titleLabel];
    }
    return result;
}

- (UIImageView *)ylt_imageView {
    UIImageView *result = objc_getAssociatedObject(self, @selector(ylt_imageView));
    if (result == nil) {
        result = [[UIImageView alloc] init];
        objc_setAssociatedObject(self, @selector(ylt_imageView), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        
    }
    return result;
}

- (UILabel *)ylt_titleLabel {
    UILabel *result = objc_getAssociatedObject(self, @selector(ylt_titleLabel));
    if (result == nil) {
        result = [[UILabel alloc] init];
        objc_setAssociatedObject(self, @selector(ylt_titleLabel), result, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return result;
}

@end
#pragma clang diagnostic pop
