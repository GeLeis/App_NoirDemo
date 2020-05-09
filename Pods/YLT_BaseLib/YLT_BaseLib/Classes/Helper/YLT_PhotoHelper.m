//
//  YLT_PhotoHelper.m
//  Pods
//
//  Created by YLT_Alex on 2017/11/9.
//

#import "YLT_PhotoHelper.h"
#import <UIKit/UIKit.h>
#import "NSObject+YLT_Extension.h"
#import "YLT_AuthorizationHelper.h"
#import "NSString+YLT_Extension.h"

@interface YLT_PhotoHelper()<UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
}

@property (nonatomic, copy) void(^success)(NSDictionary *info);
@property (nonatomic, copy) void(^failed)(NSError *error);
@property (nonatomic, strong) UIImagePickerController *pickerVC;
@property (nonatomic, assign) UIScrollViewContentInsetAdjustmentBehavior lastContentInsetAdjustmentBehavior API_AVAILABLE(ios(11.0));

@end

@implementation YLT_PhotoHelper

YLT_ShareInstance(YLT_PhotoHelper);

- (void)ylt_init {
}
/**
 使用照相机
 
 @param allowEdit 是否裁剪为正方形
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (void)ylt_photoFromCameraAllowEdit:(BOOL)allowEdit
                             success:(void(^)(NSDictionary *info))success
                              failed:(void(^)(NSError *error))failed {
    [YLT_PhotoHelper shareInstance].success = success;
    [YLT_PhotoHelper shareInstance].failed = failed;
    [[YLT_AuthorizationHelper shareInstance] ylt_authorizationType:YLT_Camera success:^{
        [YLT_PhotoHelper shareInstance].pickerVC.sourceType = UIImagePickerControllerSourceTypeCamera;
        [YLT_PhotoHelper shareInstance].pickerVC.allowsEditing = allowEdit;
        if (@available(iOS 11.0, *)) {
            [YLT_PhotoHelper shareInstance].lastContentInsetAdjustmentBehavior = [UIScrollView appearance].contentInsetAdjustmentBehavior;
            [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
        }
        [[YLT_PhotoHelper shareInstance].ylt_currentVC presentViewController:[YLT_PhotoHelper shareInstance].pickerVC animated:YES completion:nil];
    } failed:^{
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:PHAuthorizationStatusDenied userInfo:@{NSLocalizedDescriptionKey:@"无权限访问"}];
        [YLT_PhotoHelper shareInstance].failed(error);
    }];
    
}

;

/**
 使用相册
 
 @param allowEdit 是否裁剪为正方形
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (void)ylt_photoFromLibraryAllowEdit:(BOOL)allowEdit
                              success:(void(^)(NSDictionary *info))success
                               failed:(void(^)(NSError *error))failed {
    [YLT_PhotoHelper shareInstance].success = success;
    [YLT_PhotoHelper shareInstance].failed = failed;
    [[YLT_AuthorizationHelper shareInstance] ylt_authorizationType:YLT_PhotoLibrary success:^{
        [YLT_PhotoHelper shareInstance].pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        [YLT_PhotoHelper shareInstance].pickerVC.allowsEditing = allowEdit;
        if (@available(iOS 11.0, *)) {
            [YLT_PhotoHelper shareInstance].lastContentInsetAdjustmentBehavior = [UIScrollView appearance].contentInsetAdjustmentBehavior;
            [UIScrollView appearance].contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentAutomatic;
        } else {
        }
        [[YLT_PhotoHelper shareInstance].ylt_currentVC presentViewController:[YLT_PhotoHelper shareInstance].pickerVC animated:YES completion:nil];
    } failed:^{
        NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:PHAuthorizationStatusDenied userInfo:@{NSLocalizedDescriptionKey:@"无权限访问"}];
        [YLT_PhotoHelper shareInstance].failed(error);
    }];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    if ([YLT_PhotoHelper shareInstance].success) {
        [YLT_PhotoHelper shareInstance].success(info);
    }
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = self.lastContentInsetAdjustmentBehavior;
    } else {
    }
    [YLT_PhotoHelper shareInstance].pickerVC = nil;
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    NSError *error = [NSError errorWithDomain:NSOSStatusErrorDomain code:0 userInfo:@{NSLocalizedDescriptionKey:@"用户取消"}];
    [YLT_PhotoHelper shareInstance].failed(error);
    [self.pickerVC dismissViewControllerAnimated:YES completion:nil];
    if (@available(iOS 11.0, *)) {
        [UIScrollView appearance].contentInsetAdjustmentBehavior = self.lastContentInsetAdjustmentBehavior;
    } else {
    }
    [YLT_PhotoHelper shareInstance].pickerVC = nil;
}

#pragma mark - get

- (void)setYlt_allowsEditing:(BOOL)ylt_allowsEditing {
    _ylt_allowsEditing = ylt_allowsEditing;
    self.pickerVC.allowsEditing = ylt_allowsEditing;
}

- (UIImagePickerController *)pickerVC {
    if (!_pickerVC) {
        _pickerVC = [[UIImagePickerController alloc] init];
        _pickerVC.delegate = self;
    }
    return _pickerVC;
}

@end

