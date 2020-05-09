//
//  YLT_LogHelper.h
//  FastCoding
//
//  Created by 項普華 on 2019/3/12.
//

#import <Foundation/Foundation.h>
#import "YLT_BaseModel.h"
#import "YLT_DBHelper.h"

@interface YLT_LogModel : YLT_BaseModel {
}
/** 日志ID */
@property (readwrite, nonatomic, assign) NSInteger logId;
/** 日志标题 */
@property (readwrite, nonatomic, copy) NSString *title;
/** 日志内容 */
@property (readwrite, nonatomic, copy) NSString *log;
/** 备注 */
@property (readwrite, nonatomic, copy) NSString *mark;
/** 耗时 单位毫秒 */
@property (readwrite, nonatomic, assign) NSInteger time;
/** 记录时间 */
@property (readwrite, nonatomic, copy) NSString *dateTime;

- (void)saveDB:(void(^)(id response))complete;
+ (void)findDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete;
- (void)updateDB:(void(^)(id response))complete;
+ (void)updateDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete;
- (void)delDB:(void(^)(id response))complete;
+ (void)delDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete;

@end


@interface YLT_APILogModel : YLT_BaseModel {
}
/** 日志ID */
@property (readwrite, nonatomic, assign) NSInteger logId;
/**  */
@property (readwrite, nonatomic, copy) NSString *title;
/** 网络请求路径 */
@property (readwrite, nonatomic, copy) NSString *url;
/** 请求参数 */
@property (readwrite, nonatomic, copy) NSString *parameters;
/** 请求结果 */
@property (readwrite, nonatomic, copy) NSString *result;
/** 备注 */
@property (readwrite, nonatomic, copy) NSString *mark;
/** 耗时 单位毫秒 */
@property (readwrite, nonatomic, assign) NSInteger time;
/** 记录时间 */
@property (readwrite, nonatomic, copy) NSString *dateTime;

- (void)saveDB:(void(^)(id response))complete;
+ (void)findDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete;
- (void)updateDB:(void(^)(id response))complete;
+ (void)updateDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete;
- (void)delDB:(void(^)(id response))complete;
+ (void)delDB_ForConditions:(NSString *)sender complete:(void(^)(id response))complete;

@end

@interface YLT_LogHelper : NSObject

/**
 清空日志
 */
+ (void)clearLogDB:(FMDatabase *)db;

@end
