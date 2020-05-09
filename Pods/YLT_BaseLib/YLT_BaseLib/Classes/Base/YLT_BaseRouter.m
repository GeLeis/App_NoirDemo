//
//  YLT_BaseRouter.m
//  FastCoding
//
//  Created by Sean on 2018/4/28.
//

#import "YLT_BaseRouter.h"
#import "YLT_BaseMacro.h"
#import "NSObject+YLT_Router.h"

@interface YLT_BaseRouter () {
}

@end

@implementation YLT_BaseRouter

/**
 路由协议
 */
- (id)ylt_router:(NSDictionary *)params {
    YLT_LogWarn(@"路由类未实现路由方法");
    return self.ylt_router_params;
}

- (void(^)(NSError *error, id response))completion {
    if ([self.ylt_router_params.allKeys containsObject:YLT_ROUTER_COMPLETION]) {
        _completion = self.ylt_router_params[YLT_ROUTER_COMPLETION];
    } else {
        _completion = ^(NSError *error, id response) {
            YLT_LogWarn(@"回调未接入");
        };
    }
    return _completion;
}

@end
