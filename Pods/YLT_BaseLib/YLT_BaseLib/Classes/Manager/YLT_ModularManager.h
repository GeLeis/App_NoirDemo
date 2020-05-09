//
//  YLT_ModularManager.h
//  Pods
//
//  Created by YLT_Alex on 2017/11/23.
//

#import "YLT_BaseModular.h"
#import "YLT_BaseMacro.h"

@interface YLT_ModularManager : YLT_BaseModular

/**
 模块初始化
 
 @param plistPath 路径
 */
+ (void)ylt_modularWithPlistPath:(NSString *)plistPath;

@end
