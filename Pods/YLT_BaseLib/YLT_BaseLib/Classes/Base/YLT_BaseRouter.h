//
//  YLT_BaseRouter.h
//  FastCoding
//
//  Created by Sean on 2018/4/28.
//

#import <Foundation/Foundation.h>
#import "YLT_RouterManager.h"

@protocol YLT_RouterProtocol

@optional
/**
 路由协议
 */
- (id)ylt_router:(NSDictionary *)params;

@end

@interface YLT_BaseRouter : NSObject<YLT_RouterProtocol>

@property (nonatomic, copy) void(^completion)(NSError *error, id response);

@property (nonatomic, strong) NSDictionary *ylt_router_params;

@end
