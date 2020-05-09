//
//  NSFileManager+YLT_Extension.h
//  FMDB
//
//  Created by 项普华 on 2018/4/8.
//

#import <Foundation/Foundation.h>
#include <sys/xattr.h>

@interface NSFileManager (YLT_Extension)

/**
 Direcroty对应的沙盒路径URL
 
 @param directory 沙盒
 @return URL
 */
+ (NSURL *)ylt_URLForDirectory:(NSSearchPathDirectory)directory;

/**
 directory对应的沙盒路径Path
 
 @param directory 沙盒
 @return Path
 */
+ (NSString *)ylt_pathForDirectory:(NSSearchPathDirectory)directory;

/**
 Documents URL
 
 @return URL
 */
+ (NSURL *)ylt_documentsURL;

/**
 Documents Path
 
 @return Path
 */
+ (NSString *)ylt_documentsPath;

/**
 Library URL
 
 @return URL
 */
+ (NSURL *)ylt_libraryURL;

/**
 Library Path
 
 @return Path
 */
+ (NSString *)ylt_libraryPath;

/**
 Cache URL
 
 @return URL
 */
+ (NSURL *)ylt_cachesURL;

/**
 Cache Path
 
 @return Path
 */
+ (NSString *)ylt_cachesPath;

/**
 防止文件被备份
 
 @param path 路径
 @return 结果
 */
+ (BOOL)ylt_addSkipBackupAttributeToFile:(NSString *)path;

/**
 获取磁盘可用空间
 
 @return 空间大小
 */
+ (double)ylt_availableDiskSpace;

/**
 清除指定目录的缓存数据

 @param path 文件路径或文件夹路径
 */
+ (BOOL)ylt_cleanCachesPath:(NSString *)path;

/// 缓存大小
+ (CGFloat)ylt_cacheSize;

/// 缓存显示大小 K M G
+ (NSString *)ylt_cacheSizeString;

+ (BOOL)ylt_cleanAllCache;

@end
