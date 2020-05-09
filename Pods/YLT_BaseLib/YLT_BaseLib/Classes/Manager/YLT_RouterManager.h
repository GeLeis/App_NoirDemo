//
//  YLT_RouterManager.h
//  FastCoding
//
//  Created by Sean on 2018/4/28.
//

#import <Foundation/Foundation.h>

@interface YLT_RouterManager : NSObject

/**
 注册web路由

 @param webRouter webRouter
 */
+ (void)registerWebRouter:(NSString *)webRouter;

/**
 路由  默认路由实例方法

 @param routerURL 路由的URL,参数带到URL后面,默认路由实例方法  NSString *routerURL = @"ylt://classname/selectorname?username=alex&password=123456";
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToURL:(NSString *)routerURL arg:(id)arg completion:(void(^)(NSError *error, id response))completion;

/**
 路由
 
 @param routerURL 路由的URL 参数带到URL后面  NSString *routerURL = @"ylt://RouterA/shareInstance.ylt_router:?username=alex&password=123456";
 @param isClassMethod 是否是类方法：默认NO
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToURL:(NSString *)routerURL isClassMethod:(BOOL)isClassMethod arg:(id)arg completion:(void(^)(NSError *error, id response))completion;

/**
 路由  默认路由实例方法

 @param clsname 路由到对应的classname
 @param selname 方法名对应的字串 后面可以带参数
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToClassname:(NSString *)clsname selname:(NSString *)selname arg:(id)arg completion:(void(^)(NSError *error, id response))completion;

/**
 路由
 
 @param clsname 路由到对应的classname
 @param selname 方法名对应的字串 后面可以带参数
 @param isClassMethod 是否是类方法：默认NO
 @param arg 参数
 @param completion 回调
 @return 回参
 */
+ (id)ylt_routerToClassname:(NSString *)clsname selname:(NSString *)selname isClassMethod:(BOOL)isClassMethod arg:(id)arg completion:(void(^)(NSError *error, id response))completion;


/**
 路由数据分析

 @param routerURL 路由地址
 @return 数据
 */
+ (NSDictionary *)analysisURL:(NSString *)routerURL;

@end
