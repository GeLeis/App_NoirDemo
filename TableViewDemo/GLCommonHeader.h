//
//  GLCommonHeader.h
//  TableViewDemo
//
//  Created by gelei on 2020/7/21.
//  Copyright © 2020 gelei. All rights reserved.
//

#ifndef GLCommonHeader_h
#define GLCommonHeader_h
#import <CocoaLumberjack/CocoaLumberjack.h>


//定义ddlogLevel登记
static const DDLogLevel ddLogLevel = DDLogLevelError;
#endif /* GLCommonHeader_h */
/*
 不同logLevel打印的DDLog信息:
 DDLogLevelAll:
    DDLogVerbose(@"testddlog");
    DDLogError(@"error");
    DDLogWarn(@"warning");
    DDLogInfo(@"info");
    DDLogDebug(@"debug");
 DDLogLevelVerbose://详细
    DDLogVerbose(@"testddlog");
    DDLogError(@"error");
    DDLogWarn(@"warning");
    DDLogInfo(@"info");
    DDLogDebug(@"debug");
 DDLogLevelDebug:
    DDLogError(@"error");
    DDLogWarn(@"warning");
    DDLogInfo(@"info");
    DDLogDebug(@"debug");
 DDLogLevelInfo:
    DDLogError(@"error");
    DDLogWarn(@"warning");
    DDLogInfo(@"info");
 DDLogLevelWarning:
    DDLogError(@"error");
    DDLogWarn(@"warning");
 DDLogLevelError:
    DDLogError(@"error");
 */
