//
//  YLT_Tools.m
//  BlackCard
//
//  Created by 项普华 on 2018/4/8.
//  Copyright © 2018年 冒险元素. All rights reserved.
//

#import "YLT_Tools.h"
#import <MJExtension/MJExtension.h>
#import "NSString+YLT_Extension.h"

@implementation YLT_Tools

/**
 Data 转为DeviceToken
 
 @param data data
 @return DeviceToken字串
 */
+ (NSString *)ylt_deviceTokenFromData:(NSData *)deviceToken {
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    NSString *deviceTokenInString = [token stringByReplacingOccurrencesOfString:@" " withString:@""] ;
    return  deviceTokenInString;
}

/**
 json字串转字典
 
 @param jsonString 字串
 @return 结果
 */
+ (NSDictionary *)ylt_dictionaryFromString:(NSString *)jsonString {
    if ([NSString ylt_isBlankString:jsonString]) {
        return nil;
    }
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonString.mj_JSONData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&error];
    if(error) {
        return nil;
    }
    return dic;
}

/**
 生成6位随机码 （数字和英文）
 
 @return 随机码
 */
+ (NSString *)ylt_makeCode {
    return [self ylt_makeCodeIsNumber:NO length:6];
}

/**
 生成随机码
 
 @param isNumber 是否是纯数字
 @param length 长度
 @return 随机码
 */
+ (NSString *)ylt_makeCodeIsNumber:(BOOL)isNumber length:(NSInteger)length {
    NSInteger ver = 0;
    if (isNumber) {
        for (int i = 0; i < length; i++) {
            ver = ver*10 + arc4random()%10;
        }
        return [NSString stringWithFormat:@"%06li", (long)ver];
    } else {
        char data[length];
        for (int x=0;x<length;data[x++] = (char)('A' + (arc4random_uniform(26))));
        return [[NSString alloc] initWithBytes:data length:length encoding:NSUTF8StringEncoding];
    }
    return @"";
}

/**
 从framework中加载类别
 
 @param frameworkPath framework的地址
 @param classname 类名
 @return 类
 */
+ (Class)ylt_loadClassFromFrameworkPath:(NSString *)frameworkPath classname:(NSString *)classname {
    NSFileManager *manager = [NSFileManager defaultManager];
    Class cls = NULL;
    NSAssert([manager fileExistsAtPath:frameworkPath], @"找不到framework");
    NSError *error;
    NSBundle *frameworkBundle = [NSBundle bundleWithPath:frameworkPath];
    NSAssert(frameworkBundle && [frameworkBundle loadAndReturnError:&error], [error description]);
    // Load class
    cls = NSClassFromString(classname);
    NSAssert(cls != NULL, @"framework中找不到对应的类");
    return cls;
}

@end
