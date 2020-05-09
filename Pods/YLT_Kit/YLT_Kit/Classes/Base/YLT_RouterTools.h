//
//  YLT_RouterTools.h
//  AFNetworking
//
//  Created by 项普华 on 2018/9/13.
//

#import <Foundation/Foundation.h>
#import <YLT_BaseLib/YLT_BaseMacro.h>

#define YLT_ShowURL(url) [YLT_RouterTools ylt_showURL:url arg:nil completion:nil];
#define YLT_PushTo(url) [YLT_RouterTools ylt_pushToURL:url completion:nil];
#define YLT_PresentTo(url) [YLT_RouterTools ylt_presentToURL:url completion:nil];

@interface YLT_RouterTools : NSObject

YLT_ShareInstanceHeader(YLT_RouterTools);

/**
 涉及到web浏览器时的web类名，默认 YLT_BaseWebView
 */
@property (nonatomic, strong) NSString *webClassName;

/**
 路由到对应的页面
 
 @param url url
 @param completion 回调
 @return 对象
 */
+ (id)ylt_pushToURL:(NSString *)url completion:(void(^)(NSError *error, id response))completion;

/**
 路由到对应页面
 
 @param url url
 @param completion 回调
 @return 对象
 */
+ (id)ylt_presentToURL:(NSString *)url completion:(void(^)(NSError *error, id response))completion;

/**
 路由到对应的页面

 @param url url
 @param arg 参数 参数也可以带到url里面
 @param completion 回调
 @return 对象
 */
+ (id)ylt_pushToURL:(NSString *)url arg:(id)arg completion:(void(^)(NSError *error, id response))completion;

/**
 路由到对应页面

 @param url url
 @param arg 参数 参数可以带到url里面
 @param completion 回调
 @return 对象
 */
+ (id)ylt_presentToURL:(NSString *)url arg:(id)arg completion:(void(^)(NSError *error, id response))completion;

/**
 获取vc或View
 
 @param url url
 @param arg 参数
 @param completion 回调
 @return 对象
 */
+ (id)ylt_showURL:(NSString *)url arg:(id)arg completion:(void(^)(NSError *error, id response))completion;

@end
