//
//  UICollectionView+YLT_Extension.m
//  AFNetworking
//
//  Created by 项普华 on 2018/8/27.
//

#import "UICollectionView+YLT_Extension.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation UICollectionView (YLT_Extension)

/**
 批量注册CELL
 
 @param cellClassNames cell的类型名称列表
 */
- (void)registerCell:(NSArray<NSString *> *)cellClassNames {
    @weakify(self);
    [cellClassNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        Class cls = NSClassFromString(obj);
        if (cls) {
            [self registerClass:cls forCellWithReuseIdentifier:obj];
        } else {
            YLT_LogError(@"%@ 注册失败", obj);
        }
    }];
}

/**
 批量注册Header
 
 @param headerClassNames header的类型名称列表
 */
- (void)registerHeader:(NSArray<NSString *> *)headerClassNames {
    @weakify(self);
    [headerClassNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        Class cls = NSClassFromString(obj);
        if (cls) {
            [self registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:obj];
        } else {
            YLT_LogError(@"%@ 注册失败", obj);
        }
    }];
}

/**
 批量注册Footer
 
 @param footerClassNames footer的类型名称列表
 */
- (void)registerFooter:(NSArray<NSString *> *)footerClassNames {
    @weakify(self);
    [footerClassNames enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        @strongify(self);
        Class cls = NSClassFromString(obj);
        if (cls) {
            [self registerClass:cls forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:obj];
        } else {
            YLT_LogError(@"%@ 注册失败", obj);
        }
    }];
}

@end
