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

@interface AppDelegate ()
@property (nonatomic, strong) KSCrashInstallation *installation;
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    NSLog(@"%@",NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject);
    [self installCrashHandler];
    return YES;
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
