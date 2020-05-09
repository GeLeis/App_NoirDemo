//
//  YLT_BaseModel.m
//  Pods-YLT_BaseLib_Example
//
//  Created by YLT_Alex on 2017/10/26.
//

#import "YLT_BaseModel.h"
#import <MJExtension/MJExtension.h>
#import "YLT_BaseMacro.h"
#import <objc/message.h>
#import "NSString+YLT_Extension.h"
#import "NSObject+YLT_Extension.h"

#define OBJECT_MEMORY_KEY [NSString stringWithFormat:@"YLT_OBJECT_SYSTEM_%@_%@", YLT_BundleIdentifier, NSStringFromClass([self class])]
#define GROUP_MEMORY_KEY [NSString stringWithFormat:@"YLT_GROUP_SYSTEM_%@_%@", YLT_BundleIdentifier, NSStringFromClass([self class])]

@implementation YLT_BaseModel

#pragma mark - system
- (instancetype)copyWithZone:(NSZone *)zone {
    return [[self class] mj_objectWithKeyValues:self.mj_keyValues];
}

+ (instancetype)mj_objectWithKeyValues:(NSMutableDictionary *)keyValues context:(NSManagedObjectContext *)context{
    YLT_BaseModel *res = [super mj_objectWithKeyValues:keyValues context:context];
    if ((res.ylt_sourceData == nil) && [res respondsToSelector:@selector(setYlt_sourceData:)]) {
        res.ylt_sourceData = keyValues.mutableCopy;
    }
    return res;
}

#pragma mark - ORM

/**
 返回当前ORM映射
 */
+ (NSDictionary *)ylt_keyMapper {
    return @{};
}

/**
 返回数据中Model的映射
 */
+ (NSDictionary *)ylt_classInArray {
    return @{};
}

#pragma mark - MJMethod
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [[self class] ylt_keyMapper];
}

+ (NSDictionary *)mj_objectClassInArray {
    return [[self class] ylt_classInArray];
}

/**
 存储对象 存储到默认的KEY下
 
 @return 存储结果
 */
- (BOOL)ylt_save {
    return [self ylt_saveForKey:OBJECT_MEMORY_KEY];
}

/**
 存储对象
 
 @param key 存储的KEY
 @return 存储结果
 */
- (BOOL)ylt_saveForKey:(NSString *)key {
    if ([NSString ylt_isBlankString:key]) {
        YLT_LogWarn(@"KEY 不能为空");
        return NO;
    }
    if (self == nil || ![self respondsToSelector:@selector(mj_keyValues)]) {
        YLT_LogWarn(@"对象数据异常");
        return NO;
    }
    
    NSDictionary *data = [self.mj_JSONString stringByReplacingOccurrencesOfString:@"<null>" withString:@""].mj_keyValues;
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:key];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 读取默认key的对象
 
 @return 对象
 */
+ (id)ylt_read {
    return [self ylt_readForKey:OBJECT_MEMORY_KEY];
}

/**
 根据key读取对象
 
 @param key 存储的KEY
 @return 对象
 */
+ (id)ylt_readForKey:(NSString *)key {
    if ([key ylt_isValid]) {
        NSDictionary *data = nil;
        if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
            data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        }
        if ([data isKindOfClass:[NSString class]] && [data respondsToSelector:@selector(mj_JSONObject)]) {
            data = data.mj_JSONObject;
        }
        if (([[self class] respondsToSelector:@selector(mj_objectWithKeyValues:)] && [data isKindOfClass:[NSDictionary class]]) ||
            ([[self class] respondsToSelector:@selector(mj_objectArrayWithKeyValuesArray:)] && [data isKindOfClass:[NSArray class]])) {
            id result = nil;
            
            if (data) {
                @try {
                    if ([data isKindOfClass:[NSArray class]]) {
                        result = [[self class] mj_objectArrayWithKeyValuesArray:data];
                    } else {
                        result = [[self class] mj_objectWithKeyValues:data];
                    }
                } @catch (NSException *exception) {
                    YLT_LogWarn(@"%@", exception);
                } @finally {
                    return result;
                }
            }
            return result;
        } else {
            YLT_LogWarn(@"对象异常");
            return nil;
        }
    }
    return nil;
}

/**
 读取数据到当前对象
 
 @return 读取结果
 */
- (BOOL)ylt_read {
    return [self ylt_readForKey:OBJECT_MEMORY_KEY];
}

/**
 根据KEY读取数据到当前对象
 
 @param key 存储的KEY
 @return 结果
 */
- (BOOL)ylt_readForKey:(NSString *)key {
    if ([key ylt_isValid]) {
        NSDictionary *data = nil;
        if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
            data = [[NSUserDefaults standardUserDefaults] objectForKey:key];
        }
        if (data) {
            if ([data isKindOfClass:[NSString class]] && [data respondsToSelector:@selector(mj_JSONObject)]) {
                data = data.mj_JSONObject;
            }
            if (![self respondsToSelector:@selector(mj_setKeyValues:)] || ![data isKindOfClass:[NSDictionary class]]) {
                YLT_LogWarn(@"对象异常");
                return NO;
            }
            
            @try {
                [self mj_setKeyValues:data];
            } @catch (NSException *exception) {
                YLT_LogWarn(@"%@", exception);
            } @finally {
                return YES;
            }
        }
        return NO;
    }
    return NO;
}

/**
 移除当前对象
 
 @return 结果
 */
- (BOOL)ylt_remove {
    return [[self class] ylt_removeForKey:OBJECT_MEMORY_KEY];
}

/**
 根据KEY移除对象
 
 @param key 存储的KEY
 @return 结果
 */
+ (BOOL)ylt_removeForKey:(NSString *)key {
    if ([NSString ylt_isBlankString:key]) {
        YLT_LogWarn(@"KEY 不能为空");
        return NO;
    }
    if ([[[NSUserDefaults standardUserDefaults] dictionaryRepresentation].allKeys containsObject:key]) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
        return [[NSUserDefaults standardUserDefaults] synchronize];
    }
    return YES;
}

/**
 按对象分组存储 默认分组
 
 @return 存储结果
 */
- (BOOL)ylt_saveToGroup {
    return [self ylt_saveToGroupForKey:GROUP_MEMORY_KEY];
}

/**
 按对象分组存储
 
 @param key 自定义的KEY
 @return 存储结果
 */
- (BOOL)ylt_saveToGroupForKey:(NSString *)key {
    if ([NSString ylt_isBlankString:key]) {
        YLT_LogWarn(@"KEY 不能为空");
        return NO;
    }
    if (![self respondsToSelector:@selector(mj_keyValues)]) {
        YLT_LogWarn(@"对象异常");
        return NO;
    }
    NSMutableArray *list = [[NSMutableArray alloc] init];
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] && [[[NSUserDefaults standardUserDefaults] objectForKey:key] isKindOfClass:[NSArray class]]) {
        [list addObjectsFromArray:[[NSUserDefaults standardUserDefaults] objectForKey:key]];
    }
    [list addObject:[self mj_keyValues]];
    [[NSUserDefaults standardUserDefaults] setObject:list forKey:key];
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

/**
 按对象的分组读取 默认分组
 
 @return 数据
 */
+ (NSArray *)ylt_readFromGroup {
    return [self ylt_readFromGroupForKey:GROUP_MEMORY_KEY];
}

/**
 按对象的分组读取
 
 @param key 自定义的KEY
 @return 数据
 */
+ (NSArray *)ylt_readFromGroupForKey:(NSString *)key {
    if ([NSString ylt_isBlankString:key]) {
        YLT_LogWarn(@"KEY 不能为空");
        return NO;
    }
    if ([[NSUserDefaults standardUserDefaults] objectForKey:key] && [[[NSUserDefaults standardUserDefaults] objectForKey:key] isKindOfClass:[NSArray class]]) {
        return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    }
    return @[];
}

/**
 移除所有的当前Model的对象
 
 @return 移除结果
 */
+ (BOOL)ylt_removeAll {
    NSDictionary *defaults = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (NSString *key in defaults.allKeys) {
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    return [[NSUserDefaults standardUserDefaults] synchronize];
}

#pragma mark - setter getter

@end
