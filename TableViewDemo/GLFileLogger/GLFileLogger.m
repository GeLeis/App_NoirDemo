//
//  GLFileLogger.m
//  TableViewDemo
//
//  Created by gelei on 2020/7/22.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "GLFileLogger.h"

#pragma mark -- GLLogFileManager
@interface GLLogFileManager : DDLogFileManagerDefault

@end

@implementation GLLogFileManager

- (NSString *)newLogFileName {
    NSDateFormatter *dateFormatter = [self logFileDateFormatter];
    NSString *formattedDate = [dateFormatter stringFromDate:[NSDate date]];
    return [NSString stringWithFormat:@"%@-%@.log", @"gllogger", formattedDate];
}

- (NSDateFormatter *)logFileDateFormatter {
    
    //获取当前线程的字典
    NSMutableDictionary *dictionary = [[NSThread currentThread]
                                       threadDictionary];
    //设置日期格式
    NSString *dateFormat = @"yyyy-MM-dd'";
    NSString *key = [NSString stringWithFormat:@"logFileDateFormatter.%@", dateFormat];
    NSDateFormatter *dateFormatter = dictionary[key];
    
    if (dateFormatter == nil) {
        //设置日期格式
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale localeWithLocaleIdentifier:@"zh_CN"]];
        [dateFormatter setDateFormat:dateFormat];
        [dateFormatter setTimeZone:[NSTimeZone timeZoneForSecondsFromGMT:0]];
        dictionary[key] = dateFormatter;
    }
    
    return dateFormatter;
}

@end

#pragma mark -- GLFileLogger

@implementation GLFileLogger

- (DDLoggerName)loggerName {
    return @"com.gelei.filelog";
}

+ (instancetype)glLogger {
    NSString *logsDir = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
    GLLogFileManager *filemanager = [[GLLogFileManager alloc] initWithLogsDirectory:[logsDir stringByAppendingPathComponent:@"GLLogs"]];
    GLFileLogger *logger = [[GLFileLogger alloc] initWithLogFileManager:filemanager];
    return logger;
}

@end
