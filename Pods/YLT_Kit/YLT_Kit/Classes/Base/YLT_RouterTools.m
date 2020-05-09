//
//  YLT_RouterTools.m
//  AFNetworking
//
//  Created by 项普华 on 2018/9/13.
//

#import "YLT_RouterTools.h"
#import "YLT_BaseWebVC.h"
#import <YLT_BaseLib/YLT_BaseLib.h>

@implementation YLT_RouterTools

YLT_ShareInstance(YLT_RouterTools);
- (void)ylt_init {
}

/**
 路由到对应的页面
 
 @param url url
 @param completion 回调
 @return 对象
 */
+ (id)ylt_pushToURL:(NSString *)url completion:(void(^)(NSError *error, id response))completion {
    return [self ylt_pushToURL:url arg:nil completion:completion];
}

/**
 路由到对应页面
 
 @param url url
 @param completion 回调
 @return 对象
 */
+ (id)ylt_presentToURL:(NSString *)url completion:(void(^)(NSError *error, id response))completion {
    return [self ylt_presentToURL:url arg:nil completion:completion];
}

/**
 路由到对应的页面
 
 @param url url
 @param arg 参数 参数也可以带到url里面
 @param completion 回调
 @return 对象
 */
+ (id)ylt_pushToURL:(NSString *)url arg:(id)arg completion:(void(^)(NSError *error, id response))completion {
    UIViewController *vc = [self ylt_showURL:url arg:arg completion:completion];
    if ([vc isKindOfClass:[UIViewController class]]) {
        if (self.ylt_currentVC.navigationController) {
            [self.ylt_currentVC.navigationController pushViewController:vc animated:YES];
        } else {
            UINavigationController *navi = [[UINavigationController alloc] initWithRootViewController:vc];
            [self.ylt_currentVC presentViewController:navi animated:YES completion:nil];
        }
    }
    return vc;
}

/**
 路由到对应页面
 
 @param url url
 @param arg 参数 参数可以带到url里面
 @param completion 回调
 @return 对象
 */
+ (id)ylt_presentToURL:(NSString *)url arg:(id)arg completion:(void(^)(NSError *error, id response))completion {
    UIViewController *vc = [self ylt_showURL:url arg:arg completion:completion];
    if ([vc isKindOfClass:[UIViewController class]]) {
        [self.ylt_currentVC presentViewController:vc animated:YES completion:nil];
    }
    return vc;
}

/**
 获取vc或View
 
 @param url url
 @param arg 参数
 @param completion 回调
 @return 对象
 */
+ (id)ylt_showURL:(NSString *)url arg:(id)arg completion:(void(^)(NSError *error, id response))completion {
    if (url.ylt_isURL) {//是网络连接
        Class cls = NSClassFromString([YLT_RouterTools shareInstance].webClassName);
        id target;
        if ([cls respondsToSelector:@selector(ylt_webVCFromURLString:)]) {
            target = [cls performSelector:@selector(ylt_webVCFromURLString:) withObject:url];
        } else {
            target = [[cls alloc] init];
        }
        return target;
    }
    NSDictionary *data = [self analysisURL:url];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    if (data[YLT_ROUTER_ARG_DATA]) {
        [params addEntriesFromDictionary:data[YLT_ROUTER_ARG_DATA]];
    }
    if (arg) {
        if ([arg isKindOfClass:[NSDictionary class]]) {
            [params addEntriesFromDictionary:arg];
        } else {
            [params setObject:arg forKey:@"ylt_arg"];
        }
    }
    id target = [YLT_RouterManager ylt_routerToClassname:data[YLT_ROUTER_CLS_NAME] selname:data[YLT_ROUTER_SEL_NAME] isClassMethod:YES arg:arg completion:completion];
    if (![target isKindOfClass:[UIViewController class]] || ![target isKindOfClass:[UIView class]]) {
        YLT_LogError(@"路由到的类非 不能解析到");
    }
    return target;
}

+ (NSDictionary *)analysisURL:(NSString *)url {
    NSDictionary *datas = [YLT_RouterManager analysisURL:url];
    NSString *selname = datas[YLT_ROUTER_SEL_NAME];
    NSString *clsname = datas[YLT_ROUTER_CLS_NAME];
    Class cls = NSClassFromString(clsname);
    NSString *reason = [NSString stringWithFormat:@"路由类异常 %@", clsname];
    NSAssert((clsname.ylt_isValid && cls != NULL), reason);
    if (!selname.ylt_isValid) {
        selname = @"ylt_createVCWithParam:";
    }
    reason = [NSString stringWithFormat:@"路由方法异常 %@ %@", clsname, selname];
    NSAssert([cls respondsToSelector:NSSelectorFromString(selname)], reason);
    return @{YLT_ROUTER_CLS_NAME:clsname, YLT_ROUTER_SEL_NAME:selname, YLT_ROUTER_ARG_DATA:datas[YLT_ROUTER_ARG_DATA]};
}

#pragma mark - getter

- (NSString *)webClassName {
    if (!_webClassName.ylt_isValid) {
        _webClassName = NSStringFromClass([YLT_BaseWebVC class]);
    }
    return _webClassName;
}

@end
