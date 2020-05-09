//
//  UICollectionViewCell+YLT_Create.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/5/23.
//

#import "UICollectionViewCell+YLT_Create.h"
#import <YLT_BaseLib/YLT_BaseLib.h>
#import <objc/message.h>
#import <ReactiveObjC/ReactiveObjC.h>

@implementation UICollectionViewCell (YLT_Create)

+ (void)load {
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        [UICollectionViewCell ylt_swizzleInstanceMethod:@selector(initWithFrame:) withMethod:@selector(initWithYLTCollectionViewCell_Frame:)];
//    });
}

- (instancetype)initWithYLTCollectionViewCell_Frame:(CGRect)frame {
    self = [self initWithYLTCollectionViewCell_Frame:frame];
    if (self) {
        self.ylt_cellConfigUI();
    }
    return self;
}

/**
 绑定数据
 */
- (UICollectionViewCell *(^)(NSIndexPath *indexPath, id bindData))ylt_cellBindData {
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
- (UICollectionViewCell *(^)(void))ylt_cellConfigUI {
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
