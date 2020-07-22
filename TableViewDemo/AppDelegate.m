//
//  AppDelegate.m
//  TableViewDemo
//
//  Created by gelei on 2020/3/30.
//  Copyright © 2020 gelei. All rights reserved.
//

#import "AppDelegate.h"
#import <KSCrash.h>
#import <KSCrash/KSCrashInstallationEmail.h>
#import "GLCommonHeader.h"
#import <DoraemonKit/DoraemonKit.h>
#import "GLFileLogger.h"
@interface AppDelegate ()
@property (nonatomic, strong) KSCrashInstallation *installation;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
//    [self installCrashHandler];
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject);
    [self configCocoaLumberjack];
    DDLogVerbose(@"22222");
    [self configDoraemonKit];
    return YES;
}


- (void)configCocoaLumberjack {
//    NSString *fileloggerPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
//    fileloggerPath = [fileloggerPath stringByAppendingPathComponent:@"lumberlogs"];
//
//    DDLogFileManagerDefault *filemanager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:fileloggerPath defaultFileProtectionLevel:NSFileProtectionNone];
    
    //采用默认的filemanager
//    DDFileLogger *filelogger = [[DDFileLogger alloc] init];
//    DDFileLogger *filelogger = [[DDFileLogger alloc] initWithLogFileManager:filemanager];
    //自定义文件存储
    GLFileLogger *filelogger = [GLFileLogger glLogger];
    //单个日志文件,存在的最大时间,单位s,默认值60* 60 * 24
    filelogger.rollingFrequency = 60* 60 * 24;
    //单个日志文件的大小最大值,单位byte,默认值1024 * 1024
    filelogger.maximumFileSize = 1024 * 1024;
    //磁盘上日志文件的数量最大值
    filelogger.logFileManager.maximumNumberOfLogFiles = 7;
    [DDLog addLogger:filelogger];
    
    //控制台,xcode,
//    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    //oslog,代替asloger
    [DDLog addLogger:[DDOSLogger sharedInstance]];
    
    DDLogVerbose(@"Verbose");
    DDLogDebug(@"Debug");
    DDLogInfo(@"Info");
    DDLogWarn(@"Warn");
    DDLogError(@"Error");
}

- (void)configDoraemonKit{
    [[DoraemonManager shareInstance] install];
}

static void crash_callback(const KSCrashReportWriter* writer) {
    NSLog(@"***advanced_crash_callback");
//    [[(AppDelegate *)[UIApplication sharedApplication].delegate installation] sendAllReportsWithCompletion:^(NSArray *filteredReports, BOOL completed, NSError *error) {
//        if (error) {
//            NSLog(@"error = %@",error.description);
//        } else {
//            NSLog(@"%@",filteredReports);
//        }
//    }];
}

- (void)installCrashHandler {
    KSCrashInstallationEmail *installation = [KSCrashInstallationEmail sharedInstance];
    installation.recipients = @[@"869313996@qq.com"];
    installation.subject = @"Crash Report";
    installation.message = @"This is a crash report";
    installation.filenameFmt = @"crash-report-%d.txt.gz";
    
    // Uncomment to send Apple style reports instead of JSON.
    [installation setReportStyle:KSCrashEmailReportStyleApple useDefaultFilenameFormat:YES];
    [installation install];
    
    
    KSCrash *handler = [KSCrash sharedInstance];
    handler.deadlockWatchdogInterval = 8;
    handler.userInfo = nil;
    handler.onCrash = crash_callback;
    handler.monitoring = KSCrashMonitorTypeProductionSafe;
    //在崩溃期间,内存自省忽略的类
//    handler.doNotIntrospectClasses = @[@"ViewController"];
    [handler install];
    
//    NSArray *ids  =[[KSCrash sharedInstance] reportIDs];
//    NSLog(@"reportIDs = %@",ids);
//    NSDictionary *report = [[KSCrash sharedInstance] reportWithID:ids.firstObject];
//    NSLog(@"report = %@",report);
}


@end
