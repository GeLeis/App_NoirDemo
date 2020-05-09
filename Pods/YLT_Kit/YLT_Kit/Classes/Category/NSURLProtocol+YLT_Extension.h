//
//  NSURLProtocol+YLT_Extension.h
//  AFNetworking
//
//  Created by 项普华 on 2018/5/22.
//

#import <Foundation/Foundation.h>

@interface NSURLProtocol (YLT_Extension)

/**
 注册拦截的 scheme

 @param scheme scheme
 */
+ (void)ylt_registerScheme:(NSString *)scheme;

/**
 取消拦截的 scheme

 @param scheme scheme
 */
+ (void)ylt_unregisterScheme:(NSString *)scheme;

@end
