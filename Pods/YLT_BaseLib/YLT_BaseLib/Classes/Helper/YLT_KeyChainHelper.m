//
//  YLT_KeyChainHelper.m
//  MJExtension
//
//  Created by YLT_Alex on 2017/10/26.
//

#import "YLT_KeyChainHelper.h"

@implementation YLT_KeyChainHelper

YLT_ShareInstance(YLT_KeyChainHelper);

- (void)ylt_init {
}

+ (NSMutableDictionary *)ylt_getKeychainQuery:(NSString *)service{
    return [NSMutableDictionary dictionaryWithObjectsAndKeys:
            (__bridge_transfer id)kSecClassGenericPassword,
            (__bridge_transfer id)kSecClass,service,
            (__bridge_transfer id)kSecAttrService,service,
            (__bridge_transfer id)kSecAttrAccount,
            (__bridge_transfer id)kSecAttrAccessibleAfterFirstUnlock,
            (__bridge_transfer id)kSecAttrAccessible,
            nil];
}

+ (void)ylt_saveKeychainValue:(NSString *)aValue key:(NSString *)aKey{
    if (!aKey) {
        return ;
    }
    if(!aValue) {
        aValue = @"";
    }
    NSMutableDictionary * keychainQuery = [self ylt_getKeychainQuery:aKey];
    SecItemDelete((__bridge_retained CFDictionaryRef)keychainQuery);
    
    [keychainQuery setObject:[NSKeyedArchiver archivedDataWithRootObject:aValue] forKey:(__bridge_transfer id)kSecValueData];
    
    SecItemAdd((__bridge_retained CFDictionaryRef)keychainQuery, NULL);
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
    if (keychainQuery) {
        CFRelease((__bridge CFTypeRef)(keychainQuery));
    }
}

+ (NSString *)ylt_readValueWithKeychain:(NSString *)aKey
{
    NSString *ret = nil;
    NSMutableDictionary *keychainQuery = [self ylt_getKeychainQuery:aKey];
    [keychainQuery setObject:(id)kCFBooleanTrue forKey:(__bridge_transfer id)kSecReturnData];
    [keychainQuery setObject:(__bridge_transfer id)kSecMatchLimitOne forKey:(__bridge_transfer id)kSecMatchLimit];
    CFDataRef keyData = NULL;
    if (SecItemCopyMatching((__bridge CFDictionaryRef)keychainQuery, (CFTypeRef *)&keyData) == noErr) {
        @try {
            ret = (NSString *)[NSKeyedUnarchiver unarchiveObjectWithData:(__bridge NSData *)keyData];
        } @catch (NSException *e) {
            YLT_LogWarn(@"Unarchive of %@ failed: %@", aKey, e);
        } @finally {
        }
    }
    if (keyData)
        CFRelease(keyData);
    return ret;
}

+ (void)ylt_deleteKeychainValue:(NSString *)aKey {
    NSMutableDictionary *keychainQuery = [self ylt_getKeychainQuery:aKey];
    SecItemDelete((__bridge CFDictionaryRef)keychainQuery);
}

+ (NSString *)ylt_uuid {
    NSString *deviceId = [YLT_KeyChainHelper ylt_readValueWithKeychain:[NSString stringWithFormat:@"Key_DeviceUUIDString_%@", YLT_BundleIdentifier]];
    if (!deviceId || !deviceId.length) {
        deviceId = [[UIDevice currentDevice].identifierForVendor UUIDString];
        [YLT_KeyChainHelper ylt_saveKeychainValue:deviceId key:[NSString stringWithFormat:@"Key_DeviceUUIDString_%@", YLT_BundleIdentifier]];
    }
    return deviceId;
}

@end
