//
//  UICollectionViewCell+YLT_Extension.m
//  YLT_Kit
//
//  Created by 項普華 on 2019/9/3.
//

#import "UICollectionViewCell+YLT_Extension.h"

@implementation UICollectionViewCell (YLT_Extension)

@dynamic ylt_targetCollectionView;

- (UICollectionView *)ylt_targetCollectionView {
    UICollectionView *result = (UICollectionView *)self.superview;
    while (![result isKindOfClass:UICollectionView.class]) {
        result = (UICollectionView *)result.superview;
    }
    return result;
}

@end
