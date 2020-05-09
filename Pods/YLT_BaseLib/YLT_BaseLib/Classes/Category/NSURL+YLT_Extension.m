//
//  NSURL+YLT_Extension.m
//  YLT_BaseLib
//
//  Created by 項普華 on 2019/12/16.
//

#import "NSURL+YLT_Extension.h"
#import "NSObject+YLT_Extension.h"

@implementation NSURL (YLT_Extension)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        [self ylt_swizzleClassMethod:@selector(URLWithString:) withMethod:@selector(ylt_URLWithString:)];
        [self ylt_swizzleClassMethod:@selector(fileURLWithPath:) withMethod:@selector(ylt_fileURLWithPath:)];
    });
}

+ (NSURL *)ylt_URLWithString:(NSString *)urlString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)urlString,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    
    return [self ylt_URLWithString:encodedString];
}

+ (NSURL *)ylt_fileURLWithPath:(NSString *)urlString {
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)urlString,
                                                              (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                                              NULL,
                                                              kCFStringEncodingUTF8));
    
    return [self ylt_fileURLWithPath:encodedString];
}

@end
