//
//  NSArray+YLT_Log.m
//  YLT_BaseLib
//
//  Created by 项普华 on 2018/4/9.
//

#import "NSArray+YLT_Log.h"

@implementation NSArray (YLT_Log)
#ifdef DEBUG
/**
 改写数组的日志打印
 
 @param locale 本地化
 @return 打印的字串
 */
- (NSString *)descriptionWithLocale:(id)locale indent:(NSUInteger)level {
    NSMutableString *strM = [NSMutableString stringWithString:@"(\n"];
    [self enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [strM appendFormat:@"\t%@,\n", obj];
    }];
    
    [strM appendString:@")"];
    return strM;
}
#endif
@end
