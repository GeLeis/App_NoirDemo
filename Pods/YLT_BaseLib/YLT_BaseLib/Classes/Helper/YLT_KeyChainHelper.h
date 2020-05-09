//
//  YLT_KeyChainHelper.h
//  MJExtension
//
//  Created by YLT_Alex on 2017/10/26.
//

#import <Foundation/Foundation.h>
#import "YLT_BaseMacro.h"

@interface YLT_KeyChainHelper : NSObject

YLT_ShareInstanceHeader(YLT_KeyChainHelper);

/**
 储存字符串到🔑钥匙串
 
 @param aValue 对应的Value
 @param aKey   对应的Key
 */
+ (void)ylt_saveKeychainValue:(NSString *)aValue key:(NSString *)aKey;


/**
 从🔑钥匙串获取字符串
 
 @param aKey 对应的Key
 @return 返回储存的Value
 */
+ (NSString *)ylt_readValueWithKeychain:(NSString *)aKey;


/**
 从🔑钥匙串删除字符串
 
 @param aKey 对应的Key
 */
+ (void)ylt_deleteKeychainValue:(NSString *)aKey;

+ (NSString *)ylt_uuid;

@end

#define YLT_UUID [YLT_KeyChainHelper ylt_uuid]
