//
//  NSDictionary+YLT_Log.m
//  YLT_BaseLib
//
//  Created by 项普华 on 2018/4/9.
//

#import "NSDictionary+YLT_Log.h"

@implementation NSDictionary (YLT_Log)
#ifdef DEBUG
/**
 改写字典的日志打印
 
 @param locale 本地化
 @return 打印的字串
 */
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *strM = [NSMutableString stringWithString:@"{\n"];
    [self enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        [strM appendFormat:@"\t%@ = %@;\n", key, obj];
    }];
    [strM appendString:@"}\n"];
    return strM;
}
#endif
@end
