//
//  YLT_Tools.h
//  BlackCard
//
//  Created by 项普华 on 2018/4/8.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YLT_Tools : NSObject

/**
 Data 转为DeviceToken

 @param deviceToken deviceToken
 @return DeviceToken字串
 */
+ (NSString *)ylt_deviceTokenFromData:(NSData *)deviceToken;

/**
 json字串转字典

 @param jsonString 字串
 @return 结果
 */
+ (NSDictionary *)ylt_dictionaryFromString:(NSString *)jsonString;

/**
 生成6位随机码 （数字和英文）
 
 @return 随机码
 */
+ (NSString *)ylt_makeCode;

/**
 生成随机码
 
 @param isNumber 是否是纯数字
 @param length 长度
 @return 随机码
 */
+ (NSString *)ylt_makeCodeIsNumber:(BOOL)isNumber length:(NSInteger)length;

/**
 从framework中加载类别

 @param frameworkPath framework的地址
 @param classname 类名
 @return 类
 */
+ (Class)ylt_loadClassFromFrameworkPath:(NSString *)frameworkPath classname:(NSString *)classname;

@end
