//
//  UIView+YLT_Create.m
//  YLT_Kit
//
//  Created by YLT_Alex on 2017/10/31.
//

#import "UIView+YLT_Create.h"
#import <objc/message.h>
#import "UIView+YLT_GesExtension.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <ReactiveObjC/ReactiveObjC.h>

@interface UIView (YLT_Data)

/**
 当前view绑定的data
 */
@property (nonatomic, strong) id viewData;
/**
 view点击事件
 */
@property (nonatomic, copy) void(^viewClickBlock)(id response);

@end

@implementation UIView (YLT_Data)

@dynamic viewData;
@dynamic viewClickBlock;

- (void)setViewData:(id)viewData {
    objc_setAssociatedObject(self, @selector(viewData), viewData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)viewData {
    return objc_getAssociatedObject(self, @selector(viewData));
}

- (void)setViewClickBlock:(void(^)(id response))viewClickBlock {
    objc_setAssociatedObject(self, @selector(viewClickBlock), viewClickBlock, OBJC_ASSOCIATION_COPY);
}

- (void(^)(id response))viewClickBlock {
    return objc_getAssociatedObject(self, @selector(viewClickBlock));
}

- (void)tapAction:(UITapGestureRecognizer *)sender {
    if (self.viewClickBlock) {
        self.viewClickBlock(self);
    }
}

@end

@implementation UIView (YLT_Create)

+ (UIView *(^)(void))ylt_create {
    @weakify(self);
    return ^id() {
        @strongify(self);
        UIView *result = [[[self class] alloc] init];
        return result;
    };
}
/**
 视图的创建
 */
+ (UIView *(^)(UIView *superView, void (^)(MASConstraintMaker *make)))ylt_createLayout {
    @weakify(self);
    return ^id(UIView *superView, void (^layout)(MASConstraintMaker *make)) {
        @strongify(self);
        UIView *result = [[[self class] alloc] init];
        if (superView) {
            [superView addSubview:result];
            if (layout) {
                [result mas_makeConstraints:layout];
            } else {
                [result mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(superView);
                }];
            }
        }
        return result;
    };
}
/**
 视图的创建frame
 */
+ (UIView *(^)(UIView *superView, CGRect frame))ylt_createFrame {
    @weakify(self);
    return ^id(UIView *superView, CGRect frame) {
        @strongify(self);
        UIView *result = [[[self class] alloc] initWithFrame:frame];
        if (superView) {
            [superView addSubview:result];
        }
        
        return result;
    };
}
/**
 视图的布局
 */
- (UIView *(^)(void (^)(MASConstraintMaker *make)))ylt_layout {
    @weakify(self);
    return ^id(void (^layout)(MASConstraintMaker *make)) {
        @strongify(self);
        if (self.superview) {
            if (layout) {
                [self mas_makeConstraints:layout];
            } else {
                [self mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.equalTo(self.superview);
                }];
            }
        }
        return self;
    };
}
/**
 视图的创建frame
 */
- (UIView *(^)(CGRect frame))ylt_frame {
    @weakify(self);
    return ^id(CGRect frame) {
        @strongify(self);
        self.frame = frame;
        return self;
    };
}
/**
 设置视图上的数据显示
 */
- (UIView *(^)(id data))ylt_data {
    @weakify(self);
    return ^id(id data) {
        @strongify(self);
        self.viewData = data;
        return self;
    };
}
/**
 设置背景颜色
 */
- (UIView *(^)(UIColor *bgColor))ylt_backgroundColor {
    @weakify(self);
    return ^id(UIColor *bgColor) {
        @strongify(self);
        self.backgroundColor = bgColor;
        return self;
    };
}
/**
 设置圆角
 */
- (UIView *(^)(NSInteger radius))ylt_radius {
    @weakify(self);
    return ^id(NSInteger radius) {
        @strongify(self);
        self.layer.cornerRadius = radius;
        self.layer.masksToBounds = YES;
        return self;
    };
}
/**
 设置边框颜色
 */
- (UIView *(^)(UIColor *borderColor))ylt_borderColor {
    @weakify(self);
    return ^id(UIColor *borderColor) {
        @strongify(self);
        self.layer.borderColor = borderColor.CGColor;
        return self;
    };
}
/**
 设置边框宽度
 */
- (UIView *(^)(CGFloat borderWidth))ylt_borderWidth  {
    @weakify(self);
    return ^id(CGFloat borderWidth) {
        @strongify(self);
        self.layer.borderWidth = borderWidth;
        return self;
    };
}
/**
 设置阴影颜色
 */
- (UIView *(^)(UIColor *shadowColor))ylt_shadowColor {
    @weakify(self);
    return ^id(UIColor *shadowColor) {
        @strongify(self);
        self.layer.shadowColor = shadowColor.CGColor;
        return self;
    };
}
/**
 设置阴影的大小
 */
- (UIView *(^)(CGSize shadowOffset))ylt_shadowSize {
    @weakify(self);
    return ^id(CGSize shadowOffset) {
        @strongify(self);
        self.layer.shadowOffset = shadowOffset;
        return self;
    };
}
/**
 设置阴影模糊度
 */
- (UIView *(^)(CGFloat blur))ylt_blur {
    @weakify(self);
    return ^id(CGFloat blur) {
        @strongify(self);
        self.layer.shadowRadius = blur;
        return self;
    };
}
/**
 设置tag
 */
- (UIView *(^)(NSInteger tag))ylt_tag {
    @weakify(self);
    return ^id(NSInteger tag) {
        @strongify(self);
        self.tag = tag;
        return self;
    };
}
/**
 设置透明度
 */
- (UIView *(^)(CGFloat alpha))ylt_alpha {
    @weakify(self);
    return ^id(CGFloat alpha) {
        @strongify(self);
        self.alpha = alpha;
        return self;
    };
}
/**
 设置触摸是否可用
 */
- (UIView *(^)(BOOL userInteractionEnabled))ylt_userInteractionEnabled {
    @weakify(self);
    return ^id(BOOL userInteractionEnabled) {
        @strongify(self);
        self.userInteractionEnabled = userInteractionEnabled;
        return self;
    };
}
/**
 赋值
 */
- (UIView *(^)(UIView **target))ylt_target {
    @weakify(self);
    return ^id(UIView **target) {
        @strongify(self);
        *target = self;
        return self;
    };
}
/**
 点击事件
 */
- (UIView *(^)(void (^)(id response)))ylt_clickBlock {
    @weakify(self);
    return ^id(void (^clickBlock)(id response)) {
        @strongify(self);
        self.viewClickBlock = clickBlock;
        self.userInteractionEnabled = YES;
        self.ylt_tap(self, @selector(tapAction:));
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

#pragma mark - Convert
/**
 类型转化
 */
- (UIButton *(^)(void))ylt_convertToButton {
    @weakify(self);
    return ^id() {
        @strongify(self);
        if ([self isKindOfClass:[UIButton class]]) {
            return self;
        } else {
            NSLog(@"button 类型转化错误");
        }
        return nil;
    };
}

/**
 类型转化
 */
- (UILabel *(^)(void))ylt_convertToLabel {
    @weakify(self);
    return ^id() {
        @strongify(self);
        if ([self isKindOfClass:[UILabel class]]) {
            return self;
        } else {
            NSLog(@"label 类型转化错误");
        }
        return nil;
    };
}

/**
 类型转化
 */
- (UIImageView *(^)(void))ylt_convertToImageView {
    @weakify(self);
    return ^id() {
        @strongify(self);
        if ([self isKindOfClass:[UIImageView class]]) {
            return self;
        } else {
            NSLog(@"imageView 类型转化出错");
        }
        return nil;
    };
}

/**
 类型转化
 */
- (UITableView *(^)(void))ylt_convertToTableView {
    @weakify(self);
    return ^id() {
        @strongify(self);
        if ([self isKindOfClass:[UITableView class]]) {
            return self;
        } else {
            NSLog(@"tableView 类型转化错误");
        }
        return nil;
    };
}

- (UITextField *(^)(void))ylt_convertToTextField {
    @weakify(self);
    return ^id() {
        @strongify(self);
        if ([self isKindOfClass:[UITextField class]]) {
            return self;
        } else {
            NSLog(@"tableView 类型转化错误");
        }
        return nil;
    };
}

- (UICollectionView *(^)(void))ylt_convertToCollectionView {
    @weakify(self);
    return ^id() {
        @strongify(self);
        if ([self isKindOfClass:[UICollectionView class]]) {
            return self;
        } else {
            NSLog(@"tableView 类型转化错误");
        }
        return nil;
    };
}

/**
 获取当前对象
 
 @return 当前对象
 */
- (id)ylt_self {
    return self;
}
#pragma mark - method
/**
 获取当前视图的中心点
 
 @return 中心点
 */
- (CGPoint)ylt_selfcenter {
    return CGPointMake(self.bounds.size.width/2., self.bounds.size.height/2.);
}

/**
 获取当前view绑定的data
 
 @return data
 */
- (id)data {
    return self.viewData;
}

@end
