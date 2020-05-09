//
//  YLT_LogHelper.m
//  FastCoding
//
//  Created by 項普華 on 2019/3/12.
//

#import "YLT_LogHelper.h"
#import "NSString+YLT_Extension.h"

@implementation YLT_LogModel

- (id)init {
    self = [super init];
    if (self) {
        self.logId = 0;
        self.log = @"";
        self.mark = @"";
        self.time = 0;
        self.dateTime = @"";
    }
    return self;
}

+ (NSDictionary *)ylt_keyMapper {
    NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
    [result addEntriesFromDictionary: @{
                                        }];
    return result;
}

+ (NSDictionary *)ylt_classInArray {
    NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
    [result addEntriesFromDictionary: @{
                                        }];
    return result;
}

- (void)saveDB:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS DB_YLT_LogModel(logId INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, log TEXT, mark TEXT, time INTEGER, dateTime TEXT)"];
            if ([db executeUpdate:@"INSERT INTO DB_YLT_LogModel(title,log,mark,time,dateTime) VALUES (?,?,?,?,?)", self.title, self.log, self.mark, [NSNumber numberWithInteger:self.time], self.dateTime]) {
                result = YES;
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

+ (void)findDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSMutableArray *result = nil;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            result = [[NSMutableArray alloc] init];
            FMResultSet* set;
            if (!sender.ylt_isValid) {
                set = [db executeQuery:@"SELECT * FROM DB_YLT_LogModel"];
            } else {
                set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM DB_YLT_LogModel WHERE %@", sender]];
            }
            while ([set next]) {
                YLT_LogModel *item = [[YLT_LogModel alloc] init];
                item.logId = [set intForColumn:@"logId"];
                item.title = [set stringForColumn:@"title"];
                item.log = [set stringForColumn:@"log"];
                item.mark = [set stringForColumn:@"mark"];
                item.time = [set intForColumn:@"time"];
                item.dateTime = [set stringForColumn:@"dateTime"];
                [result addObject:item];
            }
        }
        if (complete) {
            complete(result);
        }
    }];
}

- (void)updateDB:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            if ([db executeUpdate:@"UPDATE DB_YLT_LogModel SET  title = ?, log = ?, mark = ?, time = ?, dateTime = ? WHERE logId = ?", self.title, self.log, self.mark, [NSNumber numberWithInteger:self.time], self.dateTime, [NSNumber numberWithInteger:self.logId]]) {
                result = YES;
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

+ (void)updateDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            if ([db executeUpdate:[NSString stringWithFormat:@"UPDATE DB_YLT_LogModel SET %@", sender]]) {
                result = YES;
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

- (void)delDB:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            if ([db executeUpdate:@"DELETE FROM DB_YLT_LogModel WHERE logId = ?", [NSNumber numberWithInteger:self.logId]]) {
                result = YES;
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

+ (void)delDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            if (!sender.ylt_isValid) {
                if ([db executeUpdate:[NSString stringWithFormat:@"DELETE FROM DB_YLT_LogModel"]]) {
                    result = YES;
                }
            } else {
            if ([db executeUpdate:[NSString stringWithFormat:@"DELETE FROM DB_YLT_LogModel WHERE %@", sender]]) {
                    result = YES;
                }
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

@end


@implementation YLT_APILogModel

- (id)init {
    self = [super init];
    if (self) {
        self.logId = 0;
        self.url = @"";
        self.parameters = @"";
        self.result = @"";
        self.mark = @"";
        self.time = 0;
        self.dateTime = @"";
    }
    return self;
}

+ (NSDictionary *)ylt_keyMapper {
    NSMutableDictionary *result = [super ylt_keyMapper].mutableCopy;
    [result addEntriesFromDictionary: @{
                                        }];
    return result;
}

+ (NSDictionary *)ylt_classInArray {
    NSMutableDictionary *result = [super ylt_classInArray].mutableCopy;
    [result addEntriesFromDictionary: @{
                                        }];
    return result;
}

- (void)saveDB:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            [db executeUpdate:@"CREATE TABLE IF NOT EXISTS DB_YLT_APILogModel(logId INTEGER PRIMARY KEY AUTOINCREMENT, title TEXT, url TEXT, parameters TEXT, result TEXT, mark TEXT, time INTEGER, dateTime TEXT)"];
            if ([db executeUpdate:@"INSERT INTO DB_YLT_APILogModel(title,url,parameters,result,mark,time,dateTime) VALUES (?,?,?,?,?,?,?)", self.title, self.url, self.parameters, self.result, self.mark, [NSNumber numberWithInteger:self.time], self.dateTime]) {
                result = YES;
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

+ (void)findDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        NSMutableArray *result = nil;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            result = [[NSMutableArray alloc] init];
            FMResultSet* set;
            if (!sender.ylt_isValid) {
                set = [db executeQuery:@"SELECT * FROM DB_YLT_APILogModel"];
            } else {
                set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM DB_YLT_APILogModel WHERE %@", sender]];
            }
            while ([set next]) {
                YLT_APILogModel *item = [[YLT_APILogModel alloc] init];
                item.logId = [set intForColumn:@"logId"];
                item.title = [set stringForColumn:@"title"];
                item.url = [set stringForColumn:@"url"];
                item.parameters = [set stringForColumn:@"parameters"];
                item.result = [set stringForColumn:@"result"];
                item.mark = [set stringForColumn:@"mark"];
                item.time = [set intForColumn:@"time"];
                item.dateTime = [set stringForColumn:@"dateTime"];
                [result addObject:item];
            }
        }
        if (complete) {
            complete(result);
        }
    }];
}

- (void)updateDB:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            if ([db executeUpdate:@"UPDATE DB_YLT_APILogModel SET  title = ?, url = ?, parameters = ?, result = ?, mark = ?, time = ?, dateTime = ? WHERE logId = ?", self.title, self.url, self.parameters, self.result, self.mark, [NSNumber numberWithInteger:self.time], self.dateTime, [NSNumber numberWithInteger:self.logId]]) {
                result = YES;
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

+ (void)updateDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            if ([db executeUpdate:[NSString stringWithFormat:@"UPDATE DB_YLT_APILogModel SET %@", sender]]) {
                result = YES;
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

- (void)delDB:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            if ([db executeUpdate:@"DELETE FROM DB_YLT_APILogModel WHERE logId = ?", [NSNumber numberWithInteger:self.logId]]) {
                result = YES;
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

+ (void)delDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete {
    [[YLT_DBHelper shareInstance].ylt_databaseQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL result = NO;
        if (!db.isOpen) {
            YLT_LogWarn(@"数据库错误");
        } else {
            if (!sender.ylt_isValid) {
                if ([db executeUpdate:[NSString stringWithFormat:@"DELETE FROM DB_YLT_APILogModel"]]) {
                    result = YES;
                }
            } else {
                if ([db executeUpdate:[NSString stringWithFormat:@"DELETE FROM DB_YLT_APILogModel WHERE %@", sender]]) {
                    result = YES;
                }
            }
        }
        if (complete) {
            complete(@(result));
        }
    }];
}

@end

@implementation YLT_LogHelper

/**
 清空日志
 */
+ (void)clearLogDB:(FMDatabase *)db {
    BOOL sync = NO;
    if (db == nil) {
        sync = YES;
        db = [FMDatabase databaseWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    if (![db open]) {
        YLT_LogWarn(@"数据库错误");
    }
    [db executeUpdate:@"DROP TABLE IF EXISTS DB_YLT_APILogModel"];
    [db executeUpdate:@"DROP TABLE IF EXISTS DB_YLT_LogModel"];
    [db close];
}

@end
