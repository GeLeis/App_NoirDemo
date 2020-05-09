//
//  PHAsset+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by 項普華 on 2019/12/4.
//

#import "PHAsset+YLT_Extension.h"
#import <objc/message.h>

@implementation PHAsset (YLT_Extension)

- (BOOL)ylt_isVideo {
    __block BOOL result = NO;
    NSArray<PHAssetResource *> *list = [PHAssetResource assetResourcesForAsset:self];
    [list enumerateObjectsUsingBlock:^(PHAssetResource * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == PHAssetResourceTypeVideo ||
            obj.type == PHAssetResourceTypeFullSizeVideo) {
            result = YES;
        }
        if (@available(iOS 9.1, *)) {
            if (obj.type == PHAssetResourceTypePairedVideo) {
                result = YES;
            }
        }
        if (@available(iOS 10, *)) {
            if (obj.type == PHAssetResourceTypeFullSizePairedVideo ||
                obj.type == PHAssetResourceTypeAdjustmentBasePairedVideo) {
                result = YES;
            }
        }
        if (@available(iOS 13, *)) {
            if (obj.type == PHAssetResourceTypeAdjustmentBaseVideo) {
                result = YES;
            }
        }
    }];
    return NO;
}

- (BOOL)ylt_isImage {
    __block BOOL result = NO;
    NSArray<PHAssetResource *> *list = [PHAssetResource assetResourcesForAsset:self];
    [list enumerateObjectsUsingBlock:^(PHAssetResource * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == PHAssetResourceTypePhoto ||
            obj.type == PHAssetResourceTypeAlternatePhoto ||
            obj.type == PHAssetResourceTypeFullSizePhoto) {
            result = YES;
        }
    }];
    return NO;
}

- (BOOL)ylt_isAudio {
    __block BOOL result = NO;
    NSArray<PHAssetResource *> *list = [PHAssetResource assetResourcesForAsset:self];
    [list enumerateObjectsUsingBlock:^(PHAssetResource * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (obj.type == PHAssetResourceTypeAudio) {
            result = YES;
        }
    }];
    return NO;
}

@end
