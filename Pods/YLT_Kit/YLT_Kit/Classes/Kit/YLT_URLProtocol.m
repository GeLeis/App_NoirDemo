//
//  YLT_URLProtocol.m
//  YLT_Kit_Example
//
//  Created by 项普华 on 2018/5/22.
//  Copyright © 2018年 xphaijj0305@126.com. All rights reserved.
//

#import "YLT_URLProtocol.h"

static NSString* const FilteredKey = @"FilteredKey";

@implementation YLT_URLProtocol

+ (BOOL)canInitWithRequest:(NSURLRequest *)request {
    NSString* extension = request.URL.pathExtension;
    BOOL isImage = [@[@"png", @"jpeg", @"gif", @"jpg"] indexOfObjectPassingTest:^BOOL(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        return [extension compare:obj options:NSCaseInsensitiveSearch] == NSOrderedSame;
    }] != NSNotFound;
    return [NSURLProtocol propertyForKey:FilteredKey inRequest:request] == nil && isImage;
}

+ (NSURLRequest *)canonicalRequestForRequest:(NSURLRequest *)request {
    return request;
}

- (void)startLoading {
    NSMutableURLRequest* request = self.request.mutableCopy;
    [NSURLProtocol setProperty:@YES forKey:FilteredKey inRequest:request];
    
    NSData* data = UIImagePNGRepresentation([UIImage imageNamed:@"image"]);
    NSURLResponse* response = [[NSURLResponse alloc] initWithURL:self.request.URL MIMEType:@"image/png" expectedContentLength:data.length textEncodingName:nil];
    [self.client URLProtocol:self didReceiveResponse:response cacheStoragePolicy:NSURLCacheStorageAllowed];
    [self.client URLProtocol:self didLoadData:data];
    [self.client URLProtocolDidFinishLoading:self];
}

- (void)stopLoading {
}

@end
