//
//  YLT_PhotoHelper.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/9.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
#import "YLT_BaseMacro.h"

@interface YLT_PhotoHelper : NSObject

YLT_ShareInstanceHeader(YLT_PhotoHelper);

/**
 是否可以编辑 默认NO
 */
@property (nonatomic, assign) BOOL ylt_allowsEditing;

/**
 使用照相机
 
 @param allowEdit 是否裁剪为正方形
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (void)ylt_photoFromCameraAllowEdit:(BOOL)allowEdit
                             success:(void(^)(NSDictionary *info))success
                              failed:(void(^)(NSError *error))failed;

/**
 使用相册
 
 @param allowEdit 是否裁剪为正方形
 @param success 成功的回调
 @param failed 失败的回调
 */
+ (void)ylt_photoFromLibraryAllowEdit:(BOOL)allowEdit
                              success:(void(^)(NSDictionary *info))success
                               failed:(void(^)(NSError *error))failed;

@end

