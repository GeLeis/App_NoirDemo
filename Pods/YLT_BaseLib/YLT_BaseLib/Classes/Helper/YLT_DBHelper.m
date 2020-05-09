//
//  YLT_DBHelper.m
//  MJExtension
//
//  Created by YLT_Alex on 2017/11/3.
//

#import "YLT_DBHelper.h"
#import <sqlite3.h>

@interface YLT_DBHelper () {
}
@property (nonatomic, strong) NSMutableArray<NSString *> *ylt_allDBPaths;
@end

@implementation YLT_DBHelper

YLT_ShareInstance(YLT_DBHelper);
@synthesize ylt_allUserDBPaths = _ylt_allUserDBPaths;
@synthesize ylt_dbVersion = _ylt_dbVersion;

- (void)ylt_init {
}

- (NSString *)ylt_dbPath {
    if (!_ylt_dbPath) {
        _ylt_dbPath = [YLT_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.db", YLT_BundleIdentifier]];
    }
    return _ylt_dbPath;
}

- (FMDatabaseQueue *)ylt_databaseQueue {
    if (!_ylt_databaseQueue) {
        _ylt_databaseQueue = [FMDatabaseQueue databaseQueueWithPath:[YLT_DBHelper shareInstance].ylt_dbPath];
    }
    return _ylt_databaseQueue;
}

- (NSString *)ylt_userDbPath {
    if (!_ylt_userDbPath) {
        _ylt_userDbPath = [YLT_DOCUMENT_PATH stringByAppendingPathComponent:[NSString stringWithFormat:@"%@%@.db", self.ylt_userPath?:@"", YLT_BundleIdentifier]];
    }
    return _ylt_userDbPath;
}

- (FMDatabaseQueue *)ylt_userDbQueue {
    if (!_ylt_userDbQueue) {
        _ylt_userDbQueue = [FMDatabaseQueue databaseQueueWithPath:self.ylt_userDbPath];
    }
    return _ylt_userDbQueue;
}

- (void)ylt_dbReset {
    self.ylt_userPath = nil;
    self.ylt_userDbPath = nil;
    self.ylt_userDbQueue = nil;
}

- (NSMutableArray<NSString *> *)ylt_allUserDBPaths {
    if (_ylt_allUserDBPaths == nil) {
        _ylt_allUserDBPaths = [[NSMutableArray alloc] init];
    }
    [_ylt_allUserDBPaths removeAllObjects];
    [_ylt_allUserDBPaths addObjectsFromArray:self.ylt_allDBPaths];
    [_ylt_allUserDBPaths removeObject:self.ylt_dbPath];
    return _ylt_allUserDBPaths;
}

#define YLT_DB_VERSION @"YLT_DB_VERSION"

- (NSInteger)ylt_dbVersion {
    if (_ylt_dbVersion == 0) {
        _ylt_dbVersion = [[[NSUserDefaults standardUserDefaults] objectForKey:YLT_DB_VERSION] integerValue];
    }
    return _ylt_dbVersion;
}

- (void)setYlt_dbVersion:(NSInteger)ylt_dbVersion {
    _ylt_dbVersion = ylt_dbVersion;
    [[NSUserDefaults standardUserDefaults] setObject:@(_ylt_dbVersion) forKey:YLT_DB_VERSION];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self ylt_dbReset];
}


- (NSMutableArray<NSString *> *)ylt_allDBPaths {
    if (_ylt_allDBPaths == nil) {
        _ylt_allDBPaths = [[NSMutableArray alloc] init];
    }
    [_ylt_allDBPaths removeAllObjects];
    NSArray<NSString *> *files = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:YLT_DOCUMENT_PATH error:nil];
    NSPredicate *predicate = nil;
    predicate = [NSPredicate predicateWithFormat:@"SELF ENDSWITH '.db'"];
    [[files filteredArrayUsingPredicate:predicate] enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [_ylt_allDBPaths addObject:[NSString stringWithFormat:@"%@/%@", YLT_DOCUMENT_PATH, obj]];
    }];
    return _ylt_allDBPaths;
}


@end
