//
//  UICollectionReusableView+YLT_Create.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import "UICollectionReusableView+YLT_Create.h"
#import <objc/message.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UICollectionReusableView (YLT_Create)

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [UICollectionReusableView ylt_swizzleInstanceMethod:@selector(initWithFrame:) withMethod:@selector(initWithYLTCollectionReusableView_Frame:)];
//    });
}

- (instancetype)initWithYLTCollectionReusableView_Frame:(CGRect)frame {
    self = [self initWithYLTCollectionReusableView_Frame:frame];
    if (self) {
        self.ylt_cellConfigUI();
    }
    return self;
}

/**
 绑定数据
 */
- (UICollectionReusableView *(^)(NSIndexPath *indexPath, id bindData))ylt_cellBindData {
    @weakify(self);
    return ^id(NSIndexPath *indexPath, id bindData) {
        @strongify(self);
        self.cellData = bindData;
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(ylt_indexPath:bindData:)]) {
            [self performSelector:@selector(ylt_indexPath:bindData:) withObject:indexPath withObject:bindData];
        }
#pragma clang diagnostic pop
        return self;
    };
}
/**
 处理UI
 */
- (UICollectionReusableView *(^)(void))ylt_cellConfigUI {
    @weakify(self);
    return ^id() {
        @strongify(self);
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wundeclared-selector"
        if ([self respondsToSelector:@selector(ylt_configUI)]) {
            [self performSelector:@selector(ylt_configUI)];
        }
#pragma clang diagnostic pop
        return self;
    };
}

- (void)setCellData:(id)cellData {
    objc_setAssociatedObject(self, @selector(cellData), cellData, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (id)cellData {
    return objc_getAssociatedObject(self, @selector(cellData));
}

@end
