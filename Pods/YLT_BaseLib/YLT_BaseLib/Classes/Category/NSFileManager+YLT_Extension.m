//
//  NSFileManager+YLT_Extension.m
//  FMDB
//
//  Created by 项普华 on 2018/4/8.
//

#import "NSFileManager+YLT_Extension.h"

@implementation NSFileManager (YLT_Extension)

/**
 Direcroty对应的沙盒路径URL
 
 @param directory 沙盒
 @return URL
 */
+ (NSURL *)ylt_URLForDirectory:(NSSearchPathDirectory)directory {
    return [self.defaultManager URLsForDirectory:directory inDomains:NSUserDomainMask].lastObject;
}

/**
 directory对应的沙盒路径Path
 
 @param directory 沙盒
 @return Path
 */
+ (NSString *)ylt_pathForDirectory:(NSSearchPathDirectory)directory
{
    return NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES)[0];
}

/**
 Documents URL
 
 @return URL
 */
+ (NSURL *)ylt_documentsURL {
    return [self ylt_URLForDirectory:NSDocumentDirectory];
}

/**
 Documents Path
 
 @return Path
 */
+ (NSString *)ylt_documentsPath {
    return [self ylt_pathForDirectory:NSDocumentDirectory];
}

/**
 Library URL
 
 @return URL
 */
+ (NSURL *)ylt_libraryURL {
    return [self ylt_URLForDirectory:NSLibraryDirectory];
}

/**
 Library Path
 
 @return Path
 */
+ (NSString *)ylt_libraryPath
{
    return [self ylt_pathForDirectory:NSLibraryDirectory];
}

/**
 Cache URL
 
 @return URL
 */
+ (NSURL *)ylt_cachesURL {
    return [self ylt_URLForDirectory:NSCachesDirectory];
}

/**
 Cache Path
 
 @return Path
 */
+ (NSString *)ylt_cachesPath {
    return [self ylt_pathForDirectory:NSCachesDirectory];
}

/**
 防止文件被备份
 
 @param path 路径
 @return 结果
 */
+ (BOOL)ylt_addSkipBackupAttributeToFile:(NSString *)path {
    return [[NSURL.alloc initFileURLWithPath:path] setResourceValue:@(YES) forKey:NSURLIsExcludedFromBackupKey error:nil];
}

/**
 获取磁盘可用空间
 
 @return 空间大小
 */
+ (double)ylt_availableDiskSpace {
    NSDictionary *attributes = [self.defaultManager attributesOfFileSystemForPath:self.ylt_documentsPath error:nil];
    
    return [attributes[NSFileSystemFreeSize] unsignedLongLongValue] / (double)0x100000;
}

/**
 清除指定目录的缓存数据
 
 @param path 文件路径或文件夹路径
 */
+ (BOOL)ylt_cleanCachesPath:(NSString *)path {
    BOOL isDir = NO;
    BOOL isExist = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (!isExist) {
        return YES;
    }
    if (!isDir) {
        return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    }
    
    NSArray *files = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil];
    //遍历数组
    BOOL flag = NO;
    for (NSString *fileName in files) {
        NSString *filePath = [path stringByAppendingPathComponent:fileName];
        flag = [[NSFileManager defaultManager] removeItemAtPath:filePath error:nil];
        if (!flag)
            break;
    }
    
    return flag;
}

/// 缓存大小
+ (CGFloat)ylt_cacheSize {
    __block CGFloat totalSize = 0.0;
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        for (NSString *path in [[NSFileManager defaultManager] subpathsAtPath:obj]) {
            NSString *filePAath = [obj stringByAppendingString:[NSString stringWithFormat:@"/%@", path]];
            totalSize += [[NSFileManager defaultManager] attributesOfItemAtPath:filePAath error:nil].fileSize;
        }
    }];
    
    return totalSize;
}

/// 缓存显示大小 K M G
+ (NSString *)ylt_cacheSizeString {
    CGFloat totalSize = [self ylt_cacheSize];
    if (totalSize < 512) {
        return [NSString stringWithFormat:@"%.0fB", totalSize];
    }
    if (totalSize < 1024*512) {
        return [NSString stringWithFormat:@"%.0fKB", totalSize/1024.];
    }
    if (totalSize < 1024*1024*512) {
        return [NSString stringWithFormat:@"%.0fMB", totalSize/(1024.*1024)];
    }
    return [NSString stringWithFormat:@"%.0fGB", totalSize/(1024.*1024*1024)];
}

+ (BOOL)ylt_cleanAllCache {
    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) enumerateObjectsUsingBlock:^(NSString * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSArray*files = [[NSFileManager defaultManager] subpathsAtPath:obj];
        for(NSString *filePath in files){
            NSError *error;
            NSString*path = [obj stringByAppendingString:[NSString stringWithFormat:@"/%@",filePath]];
            if([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
            }
        }
    }];
    
    return YES;
}

@end
